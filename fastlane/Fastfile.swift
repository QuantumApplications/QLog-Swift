// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {

    func testLane() {
        // Carthage 0.36 is still needed because
        // - Carthage 0.37 does not support Xcode 12
        // - Carthage 0.38 does not support nested dependencies
        sh(command: "./carthage-build.sh bootstrap --platform ios --no-use-binaries --cache-builds")
        runTests(scheme: "QLog", device: "iPhone 12 Pro Max")
    }

}
