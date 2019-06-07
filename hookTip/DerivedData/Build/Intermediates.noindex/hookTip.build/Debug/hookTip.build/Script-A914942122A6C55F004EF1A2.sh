#!/bin/sh
cd ${TARGET_BUILD_DIR}
export DYLD_INSERT_LIBRARIES=./libhookTip.dylib && /Users/ch4r0n/Desktop/MacOSReserver/TryToHookSwift/hookTip/hookTip/SwiftTipWindows.app/Contents/MacOS/SwiftTipWindows

