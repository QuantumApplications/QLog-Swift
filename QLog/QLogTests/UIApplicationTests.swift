//
//  UIApplicationTests.swift
//  QLogTests
//
//  Created by Christian Oberdörfer on 10.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import XCTest

class UIApplicationTests: XCTestCase {

    func testTopViewController() {
        // 3. Assert
        XCTAssertEqual(UIApplication.topViewController(), nil)
    }

}
