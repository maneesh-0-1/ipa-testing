#!/bin/sh
set -e

# Xcode Cloud ci_post_clone.sh

# 1. Navigate to the root of the repository
if [ -n "$CI_PRIMARY_REPOSITORY_PATH" ]; then
  cd "$CI_PRIMARY_REPOSITORY_PATH"
elif [ -n "$CI_WORKSPACE" ]; then
  cd "$CI_WORKSPACE"
elif [ -d "ios" ]; then
  true
elif [ -d "../../ios" ]; then
  cd ../..
elif [ -d "../ios" ]; then
  cd ..
fi

echo "Repository root: $(pwd)"

# Avoid git dubious ownership errors in CI containers
git config --global --add safe.directory "*" || true

# 2. Configure GEM and PATH for fast CocoaPods installation
export GEM_HOME="$HOME/gems"
export PATH="$GEM_HOME/bin:/opt/homebrew/bin:/usr/local/bin:${PATH}"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1

# 3. Fast CocoaPods installation via RubyGems (takes ~15-30s instead of minutes with brew)
if ! command -v pod >/dev/null 2>&1; then
  echo "CocoaPods not found. Installing via RubyGems..."
  gem install cocoapods -v 1.16.2 --no-document --install-dir "$GEM_HOME" || {
    echo "gem install failed, falling back to brew install..."
    brew install cocoapods || true
  }
fi

echo "CocoaPods path: $(command -v pod)"
echo "CocoaPods version: $(pod --version)"

# 4. Install / Verify Flutter SDK matching pubspec.lock (>=3.44.0)
FLUTTER_VERSION="${FLUTTER_VERSION:-3.44.7}"
FLUTTER_ROOT="${HOME}/flutter"

NEED_CLONE=false
if [ ! -x "${FLUTTER_ROOT}/bin/flutter" ]; then
  NEED_CLONE=true
elif [ -f "${FLUTTER_ROOT}/version" ]; then
  CACHED_VERSION=$(cat "${FLUTTER_ROOT}/version" 2>/dev/null || true)
  if [ "$CACHED_VERSION" != "$FLUTTER_VERSION" ] && [ "$FLUTTER_VERSION" != "stable" ]; then
    echo "Cached Flutter version ($CACHED_VERSION) does not match requested ($FLUTTER_VERSION)."
    NEED_CLONE=true
  fi
fi

if [ "$NEED_CLONE" = true ]; then
  echo "Cloning Flutter SDK (${FLUTTER_VERSION})..."
  rm -rf "${FLUTTER_ROOT}"
  git clone --depth 1 --branch "${FLUTTER_VERSION}" --progress https://github.com/flutter/flutter.git "${FLUTTER_ROOT}"
fi

export PATH="${FLUTTER_ROOT}/bin:${PATH}"

echo "=== Flutter Version ==="
flutter --version

echo "=== Flutter Precache iOS ==="
flutter precache --ios

echo "=== Running Flutter Pub Get ==="
flutter pub get

echo "=== Configuring iOS Project & Swift Packages ==="
# Generates ios/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage and Generated.xcconfig
flutter build ios --config-only --no-codesign

echo "=== Running Pod Install ==="
cd ios
# Run pod install with verbose streaming so Xcode Cloud never detects inactivity
pod install --verbose
if [ -f "Pods/Target Support Files/Pods-Runner/Pods-Runner-frameworks.sh" ]; then
  sed -i.bak -e 's/source="$(readlink "${source}")"/source="$(readlink -f "${source}")"/g' "Pods/Target Support Files/Pods-Runner/Pods-Runner-frameworks.sh" || true
fi
cd ..

echo "=== Synchronizing Package.resolved & Shared Schemes ==="
mkdir -p ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/swiftpm
mkdir -p ios/Runner.xcworkspace/xcshareddata/swiftpm

if [ -f "ios/Runner.xcworkspace/xcshareddata/swiftpm/Package.resolved" ] && [ ! -f "ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved" ]; then
  cp "ios/Runner.xcworkspace/xcshareddata/swiftpm/Package.resolved" "ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved"
elif [ -f "ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved" ] && [ ! -f "ios/Runner.xcworkspace/xcshareddata/swiftpm/Package.resolved" ]; then
  cp "ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved" "ios/Runner.xcworkspace/xcshareddata/swiftpm/Package.resolved"
fi

mkdir -p ios/Runner.xcworkspace/xcshareddata/xcschemes
if [ -f "ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme" ] && [ ! -f "ios/Runner.xcworkspace/xcshareddata/xcschemes/Runner.xcscheme" ]; then
  cp "ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme" "ios/Runner.xcworkspace/xcshareddata/xcschemes/Runner.xcscheme"
fi

echo "=== Verifying Generated Artifacts ==="
if [ -d "ios/Pods/GoogleMaps" ]; then
  echo "GoogleMaps pod is present in ios/Pods/GoogleMaps."
else
  echo "Checking Pods directory:"
  ls -la ios/Pods || true
fi

if [ -d "ios/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage" ]; then
  echo "FlutterGeneratedPluginSwiftPackage is present."
else
  echo "WARNING: FlutterGeneratedPluginSwiftPackage was not found!"
fi

if [ -f "ios/Flutter/Generated.xcconfig" ]; then
  echo "Generated.xcconfig is present."
else
  echo "WARNING: Generated.xcconfig was not found!"
fi

echo "Xcode Cloud ci_post_clone.sh finished successfully."
exit 0
