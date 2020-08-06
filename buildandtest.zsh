#!/bin/zsh
#swift build
#.build/debug/SwiftSpecConsole

RELATIVE_PATH_TO_FEATURES="Tests/SwiftSpecTests/Features"
ABSOLUTE_PATH_TO_FEATURES="$PWD/$RELATIVE_PATH_TO_FEATURES"

swift build
.build/debug/SwiftSpecConsole $RELATIVE_PATH_TO_FEATURES
swift test
