//
//  LogViewer.swift
//  LogViewer
//
//  Created by Christian Oberdörfer on 21.06.17.
//  Copyright © 2017 QuineSoft. All rights reserved.
//

import MobileCoreServices

/// Needs to be global, otherwise the controller will be destroyed when the file is handed over to target application
var documentInteractionController: UIDocumentInteractionController!

// Needs to inherit from NSObject to allow selectors working properly

public class LogViewer: NSObject {

    static let font = UIFont.monospacedDigitSystemFont(ofSize: 12, weight: UIFontWeightMedium)
    static let shared = LogViewer()

    public static var textColor = UIColor.red
    public static var debugColor = UIColor.blue
    public static var infoColor = UIColor.green
    public static var warningColor = UIColor.yellow
    public static var errorColor = UIColor.red
    public static var logUrl: URL?

    var viewController: LogViewController?
    var logFileHandle: FileHandle?

    public static func enable() {
        // Register observer to be notified when a new window appears
        NotificationCenter.default.addObserver(LogViewer.shared, selector: #selector(registerGestureRecognizer), name: .UIWindowDidBecomeVisible, object: nil)
        LogViewer.shared.createViewController()
        // Prepare log path
        if LogViewer.logUrl != nil {
            let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
            let logDirectoryUrl = LogViewer.logUrl!.appendingPathComponent(appName)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let logFileName = dateFormatter.string(from: Date()) + ".log"
            let logFileUrl = logDirectoryUrl.appendingPathComponent(logFileName)
            do {
                try FileManager.default.createDirectory(at: logDirectoryUrl, withIntermediateDirectories: true, attributes: nil)
                if FileManager.default.createFile(atPath: logFileUrl.path, contents: nil, attributes: nil) {
                    if let logFileHandle = FileHandle(forWritingAtPath: logFileUrl.path) {
                        LogViewer.shared.logFileHandle = logFileHandle
                    }
                }
            } catch {
            }
        }
    }

    public static func logDebug<T>(_ object: T, file: String, function: String, line: String, date: Date) {
        LogViewer.log(object, file: file, function: function, line: line, date: date, logLevel: "DEBUG", color: LogViewer.debugColor)
    }

    public static func logInfo<T>(_ object: T, file: String, function: String, line: String, date: Date) {
        LogViewer.log(object, file: file, function: function, line: line, date: date, logLevel: "INFO", color: LogViewer.infoColor)
    }

    public static func logWarning<T>(_ object: T, file: String, function: String, line: String, date: Date) {
        LogViewer.log(object, file: file, function: function, line: line, date: date, logLevel: "WARNING", color: LogViewer.warningColor)
    }

    public static func logError<T>(_ object: T, file: String, function: String, line: String, date: Date) {
        LogViewer.log(object, file: file, function: function, line: line, date: date, logLevel: "ERROR", color: LogViewer.errorColor)
    }

    static func log<T>(_ object: T, file: String, function: String, line: String, date: Date, logLevel: String, color: UIColor) {
        // Convert object to text
        var text = ""
        if let objectString = object as? String {
            text = objectString
        } else {
            let objectString = String(describing: object)
            text = objectString
        }
        // Create log text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let metaText = "\(dateFormatter.string(from: date)): \((file as NSString).lastPathComponent):\(line) \(function): "
        // Log into view controller
        DispatchQueue.main.async {
            guard let viewController = LogViewer.shared.viewController else {
                return
            }
            let attributedMetaText = NSMutableAttributedString(string: "\n\(metaText)", attributes: [NSForegroundColorAttributeName: LogViewer.textColor, NSFontAttributeName: LogViewer.font])
            let attributedText = NSMutableAttributedString(string: "\(text)", attributes: [NSForegroundColorAttributeName: color, NSFontAttributeName: LogViewer.font])
            let oldText = NSMutableAttributedString(attributedString: (viewController.textView.attributedText))
            oldText.append(attributedMetaText)
            oldText.append(attributedText)
            viewController.textView.attributedText = oldText
        }
        // Log into file
        LogViewer.shared.logFileHandle?.write("\n\(logLevel): \(metaText)\(text)".data(using: .utf8)!)
    }

    func registerGestureRecognizer(_ notification: NSNotification) {
        // Add a gesture recognizer to the provided window
        if notification.object is UIWindow {
            let window = notification.object as! UIWindow
            // Add a gesture recognizer for each edge
            let gestureRecognizerTop = UIScreenEdgePanGestureRecognizer(target: LogViewer.shared, action: #selector(screenEdgeSwiped))
            let gestureRecognizerLeft = UIScreenEdgePanGestureRecognizer(target: LogViewer.shared, action: #selector(screenEdgeSwiped))
            let gestureRecognizerBottom = UIScreenEdgePanGestureRecognizer(target: LogViewer.shared, action: #selector(screenEdgeSwiped))
            let gestureRecognizerRight = UIScreenEdgePanGestureRecognizer(target: LogViewer.shared, action: #selector(screenEdgeSwiped))
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
        // Check if device orientation matches required recognizer
        switch UIApplication.shared.statusBarOrientation {
        case .landscapeLeft:
            if recognizer.edges != .top {
                return
            }
        case .portraitUpsideDown:
            if recognizer.edges != .left {
                return
            }
        case .landscapeRight:
            if recognizer.edges != .bottom {
                return
            }
        case .portrait:
            if recognizer.edges != .right {
                return
            }
        default:
            return
        }
        // Show the log viewer if gesture if performed at top right corner
        // 0 is the border between title bar and content
        if recognizer.state == .recognized && recognizer.location(in: UIApplication.topViewController()?.view).y < 60 {
            self.show()
        }
    }

    func createViewController() {
        // Create a new log view controller and present it
        //let viewController = LogViewController(nibName: "LogViewController", bundle: bundle)
        guard let bundle = Bundle(identifier: "de.quinesoft.LogViewer") else {
            return
        }
        let viewController = LogViewController()
        guard let nib = bundle.loadNibNamed("LogViewController", owner: viewController, options: nil) else {
            return
        }
        guard nib[0] is UIView else {
            return
        }
        viewController.view = nib[0] as! UIView
        // Add bar buttons
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
        viewController.navigationItem.leftBarButtonItem = cancelButton
        let actionButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(action))
        viewController.navigationItem.rightBarButtonItem = actionButton
        // Allow scrolling if navigation bars are opaque (WTF Apple?)
        viewController.extendedLayoutIncludesOpaqueBars = true
        viewController.tabBarItem = UITabBarItem(title: "Live", image: UIImage(), tag: 1)
        self.viewController = viewController
    }
    
    func show() {
        // Prepare live log view controller
        guard let viewController = self.viewController else {
            return
        }
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.topItem?.title = "Log"
        // Prepare archive log view controller
        guard let bundle = Bundle(identifier: "de.quinesoft.LogViewer") else {
            return
        }
        let archiveViewController = AppsTableViewController(nibName: "AppsTableViewController", bundle: bundle)
        // Add bar buttons
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
        archiveViewController.navigationItem.leftBarButtonItem = cancelButton
        archiveViewController.tabBarItem = UITabBarItem(title: "Archive", image: UIImage(), tag: 2)
        let archiveNavigationController = UINavigationController(rootViewController: archiveViewController)
        archiveNavigationController.navigationBar.topItem?.title = "Archive"
        // Prepare support package view controller
        let supportPackageViewController = UIViewController()
        supportPackageViewController.tabBarItem = UITabBarItem(title: "Support Package", image: UIImage(), tag: 3)
        let supportPackageNavigationController = UINavigationController(rootViewController: supportPackageViewController)
        supportPackageNavigationController.navigationBar.topItem?.title = "Support Package"
        // Create tab bar controller
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navigationController, archiveNavigationController, supportPackageNavigationController]
        // Present tab bar controller
        UIApplication.topViewController()?.present(tabBarController, animated: true, completion: nil)
    }

    func back() {
        UIApplication.topViewController()?.dismiss(animated: true, completion: nil)
    }

    func action(_ sender: UIBarButtonItem) {
        // Get attributed text
        guard let text = self.viewController?.textView.attributedText else {
            return
        }
        // Convert attributed text to HTML
        let documentAttributes = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType]
        do {
            let htmlData = try text.data(from: NSMakeRange(0, text.length), documentAttributes: documentAttributes)
            // Save HTML to file
            let tempDirectory = NSTemporaryDirectory() as NSString
            let tempFilePath = tempDirectory.appendingPathComponent("log.htm")
            let fileManager = FileManager.default
            // Delete old file if existing
            if fileManager.fileExists(atPath: tempFilePath) {
                try fileManager.removeItem(atPath: tempFilePath)
            }
            fileManager.createFile(atPath: tempFilePath, contents: htmlData, attributes: nil)
            // Share HTML file
            documentInteractionController = UIDocumentInteractionController()
            documentInteractionController.url = URL(fileURLWithPath: tempFilePath)
            documentInteractionController.uti = String(kUTTypeHTML)
            documentInteractionController.presentOptionsMenu(from: sender, animated: true)
        } catch {
            return
        }
    }

}

// Get top view controller
// Taken from https://stackoverflow.com/a/30858591/5804550

extension UIApplication {

    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }

}
