#!/bin/sh
set -e

# Navigate to the root of the repository
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

# Install Flutter SDK
FLUTTER_VERSION="3.41.1"
FLUTTER_ROOT="${HOME}/flutter"

if [ ! -d "${FLUTTER_ROOT}" ]; then
  echo "Cloning Flutter SDK (${FLUTTER_VERSION})..."
  git clone --depth 1 --branch "${FLUTTER_VERSION}" https://github.com/flutter/flutter.git "${FLUTTER_ROOT}"
fi

export PATH="${FLUTTER_ROOT}/bin:${PATH}"

echo "Flutter version:"
flutter --version

flutter precache --ios

# Fetch dependencies and generate Flutter plugin Swift Package & ephemeral files
echo "Running flutter pub get..."
flutter pub get

# Generate ios/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage and Generated.xcconfig
echo "Configuring iOS project dependencies..."
flutter build ios --config-only --no-codesign

# Setup CocoaPods dependencies if Podfile exists
if [ -f "ios/Podfile" ]; then
  echo "Running pod install..."
  if ! which pod >/dev/null 2>&1; then
    HOMEBREW_NO_AUTO_UPDATE=1 brew install cocoapods || true
  fi
  cd ios && pod install || true
fi

echo "Xcode Cloud ci_post_clone.sh finished successfully."
exit 0
