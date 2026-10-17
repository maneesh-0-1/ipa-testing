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

# 2. Ensure Homebrew & CocoaPods paths are in PATH
export PATH="/opt/homebrew/bin:/usr/local/bin:${PATH}"

# 3. Ensure CocoaPods is installed BEFORE Flutter iOS config runs
if ! command -v pod >/dev/null 2>&1; then
  echo "CocoaPods not found. Installing via Homebrew..."
  HOMEBREW_NO_AUTO_UPDATE=1 brew install cocoapods
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
  git clone --depth 1 --branch "${FLUTTER_VERSION}" https://github.com/flutter/flutter.git "${FLUTTER_ROOT}"
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
if [ -f "ios/Podfile" ]; then
  (cd ios && pod install)
fi

echo "=== Verifying Generated Artifacts ==="
if [ -d "ios/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage" ]; then
  echo "FlutterGeneratedPluginSwiftPackage is present."
  ls -la "ios/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage"
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
