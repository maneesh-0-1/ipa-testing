#!/bin/sh

set -eu

cd "${CI_WORKSPACE:?CI_WORKSPACE must be set}"

FLUTTER_VERSION="3.41.1"
FLUTTER_ROOT="${HOME}/flutter"

if [ ! -x "${FLUTTER_ROOT}/bin/flutter" ]; then
  git clone --depth 1 --branch "${FLUTTER_VERSION}" https://github.com/flutter/flutter.git "${FLUTTER_ROOT}"
fi

export PATH="${FLUTTER_ROOT}/bin:${PATH}"

flutter precache --ios
flutter pub get

cd ios
pod install
