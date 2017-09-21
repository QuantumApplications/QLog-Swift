//
//  CornerSwipeController.swift
//  LogViewer
//
//  Created by Christian Oberdörfer on 14.09.17.
//  Copyright © 2017 QuineSoft. All rights reserved.
//

import Foundation

public class CornerSwipeController: NSObject {

    public static let shared = CornerSwipeController()

    public static var topLeftCornerHandler: (() -> Void)?
    public static var topRightCornerHandler: (() -> Void)?
    public static var bottomLeftCornerHandler: (() -> Void)?
    public static var bottomRightCornerHandler: (() -> Void)?

    static var combination = 0

    public static func enable() {
        // Register observer to be notified when a new window appears
        NotificationCenter.default.addObserver(CornerSwipeController.shared, selector: #selector(registerGestureRecognizer), name: .UIWindowDidBecomeVisible, object: nil)
        CornerSwipeController.bottomLeftCornerHandler = { _ in  CornerSwipeController.bottomLeftCombination() }
        CornerSwipeController.bottomRightCornerHandler = { _ in  CornerSwipeController.bottomRightCombination() }
    }

    func registerGestureRecognizer(_ notification: NSNotification) {
        // Add a gesture recognizer to the provided window
        if notification.object is UIWindow {
            let window = notification.object as! UIWindow
            // Add a gesture recognizer for each edge
            let gestureRecognizerTop = UIScreenEdgePanGestureRecognizer(target: CornerSwipeController.shared, action: #selector(screenEdgeSwiped))
            let gestureRecognizerLeft = UIScreenEdgePanGestureRecognizer(target: CornerSwipeController.shared, action: #selector(screenEdgeSwiped))
            let gestureRecognizerBottom = UIScreenEdgePanGestureRecognizer(target: CornerSwipeController.shared, action: #selector(screenEdgeSwiped))
            let gestureRecognizerRight = UIScreenEdgePanGestureRecognizer(target: CornerSwipeController.shared, action: #selector(screenEdgeSwiped))
            gestureRecognizerTop.edges = .top
            gestureRecognizerLeft.edges = .left
            gestureRecognizerBottom.edges = .bottom
            gestureRecognizerRight.edges = .right
            window.addGestureRecognizer(gestureRecognizerTop)
            window.addGestureRecognizer(gestureRecognizerLeft)
            window.addGestureRecognizer(gestureRecognizerBottom)
            window.addGestureRecognizer(gestureRecognizerRight)
        }
    }

    func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        // Show the log viewer if gesture if performed at top right corner
        // 0 is the border between title bar and content
        guard let frame = UIApplication.topViewController()?.view.frame.size else {
            return
        }
        let location = recognizer.location(in: UIApplication.topViewController()?.view)
        if location.x < 200 && location.y < 60 {
            // Top left corner
            CornerSwipeController.topLeftCornerHandler?()
        } else if frame.width - location.x < 200 && location.y < 60 {
            // Top right corner
            CornerSwipeController.topRightCornerHandler?()
        } else if location.x < 200 && frame.height - location.y < 160 {
            // bottom left corner
            CornerSwipeController.bottomLeftCornerHandler?()
        } else if frame.width - location.x < 200 && frame.height - location.y < 160 {
            // bottom right corner
            CornerSwipeController.bottomRightCornerHandler?()
        }
    }

    static func bottomLeftCombination() {
        switch CornerSwipeController.combination {
        case 2:
            print("Easter Egg")
        default:
            CornerSwipeController.combination = 1
        }
    }

    static func bottomRightCombination() {
        switch CornerSwipeController.combination {
        case 1:
            fallthrough
        case 2:
            CornerSwipeController.combination = 2
        default:
            CornerSwipeController.combination = 0
        }
    }

}
