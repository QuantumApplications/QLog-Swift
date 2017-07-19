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
    public static var logPath: String?

    var viewController: LogViewController?
    var logFileHandle: FileHandle?

    public static func enable() {
        // Register observer to be notified when a new window appears
        NotificationCenter.default.addObserver(LogViewer.shared, selector: #selector(registerGestureRecognizer), name: .UIWindowDidBecomeVisible, object: nil)
        LogViewer.shared.createViewController()
        // Prepare log path
        if LogViewer.logPath != nil {
            let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
            let logDirectoryPath = (LogViewer.logPath! as NSString).appendingPathComponent(appName)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let logFileName = dateFormatter.string(from: Date()) + ".log"
            let logFilePath = (logDirectoryPath as NSString).appendingPathComponent(logFileName)
            do {
                try FileManager.default.createDirectory(atPath: logDirectoryPath, withIntermediateDirectories: true, attributes: nil)
                if FileManager.default.createFile(atPath: logFilePath, contents: nil, attributes: nil) {
                    if let logFileHandle = FileHandle(forWritingAtPath: logFilePath) {
                        LogViewer.shared.logFileHandle = logFileHandle
                    }
                }
            } catch {
            }
        }
    }

    public static func logDebug<T>(_ object: T) {
        LogViewer.log(object, color: LogViewer.debugColor)
    }

    public static func logInfo<T>(_ object: T) {
        LogViewer.log(object, color: LogViewer.infoColor)
    }

    public static func logWarning<T>(_ object: T) {
        LogViewer.log(object, color: LogViewer.warningColor)
    }

    public static func logError<T>(_ object: T) {
        LogViewer.log(object, color: LogViewer.errorColor)
    }

    public static func logDebug<T>(_ object: T, file: String, function: String, line: String, date: Date) {
        LogViewer.log(object, file: file, function: function, line: line, date: date, color: LogViewer.debugColor)
    }

    public static func logInfo<T>(_ object: T, file: String, function: String, line: String, date: Date) {
        LogViewer.log(object, file: file, function: function, line: line, date: date, color: LogViewer.infoColor)
    }

    public static func logWarning<T>(_ object: T, file: String, function: String, line: String, date: Date) {
        LogViewer.log(object, file: file, function: function, line: line, date: date, color: LogViewer.warningColor)
    }

    public static func logError<T>(_ object: T, file: String, function: String, line: String, date: Date) {
        LogViewer.log(object, file: file, function: function, line: line, date: date, color: LogViewer.errorColor)
    }

    static func log<T>(_ object: T, color: UIColor) {
        var text = ""
        if let objectString = object as? String {
            text = objectString
        } else {
            let objectString = String(describing: object)
            text = objectString
        }
        let attributedText = NSMutableAttributedString(string: "\n\(text)", attributes: [NSForegroundColorAttributeName: color, NSFontAttributeName: LogViewer.font])
        let oldText = NSMutableAttributedString(attributedString: (LogViewer.shared.viewController?.textView.attributedText)!)
        oldText.append(attributedText)
        LogViewer.shared.viewController?.textView.attributedText = oldText
    }

    static func log<T>(_ object: T, file: String, function: String, line: String, date: Date, color: UIColor) {
        var text = ""
        if let objectString = object as? String {
            text = objectString
        } else {
            let objectString = String(describing: object)
            text = objectString
        }
        DispatchQueue.main.async {
            guard let viewController = LogViewer.shared.viewController else {
                return
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let attributedText1 = NSMutableAttributedString(string: "\n\(dateFormatter.string(from: date)): \((file as NSString).lastPathComponent):\(line) \(function): ", attributes: [NSForegroundColorAttributeName: LogViewer.textColor, NSFontAttributeName: LogViewer.font])
            let attributedText2 = NSMutableAttributedString(string: "\(text)", attributes: [NSForegroundColorAttributeName: color, NSFontAttributeName: LogViewer.font])
            let oldText = NSMutableAttributedString(attributedString: (viewController.textView.attributedText))
            oldText.append(attributedText1)
            oldText.append(attributedText2)
            viewController.textView.attributedText = oldText
        }
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
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
        backButton.tintColor = UIColor(colorLiteralRed: 0.921, green: 0.694, blue: 0.247, alpha: 1.000)
        let actionButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(action))
        actionButton.tintColor = UIColor(colorLiteralRed: 0.921, green: 0.694, blue: 0.247, alpha: 1.000)
        viewController.navigationItem.leftBarButtonItem = backButton
        viewController.navigationItem.rightBarButtonItem = actionButton
        // Allow scrolling if navigation bars are opaque (WTF Apple?)
        viewController.extendedLayoutIncludesOpaqueBars = true
        viewController.tabBarItem = UITabBarItem(title: "Live", image: UIImage(), tag: 1)
        self.viewController = viewController
    }
    
    func show() {
        guard let viewController = self.viewController else {
            return
        }
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.topItem?.title = "Log"
        let tabBarController = UITabBarController()
        let archiveViewController = UIViewController()
        archiveViewController.tabBarItem = UITabBarItem(title: "Archive", image: UIImage(), tag: 2)
        let archiveNavigationController = UINavigationController(rootViewController: archiveViewController)
        archiveNavigationController.navigationBar.topItem?.title = "Archive"
        let supportPackageViewController = UIViewController()
        supportPackageViewController.tabBarItem = UITabBarItem(title: "Support Package", image: UIImage(), tag: 2)
        let supportPackageNavigationController = UINavigationController(rootViewController: supportPackageViewController)
        supportPackageNavigationController.navigationBar.topItem?.title = "Support Package"
        tabBarController.viewControllers = [navigationController, archiveNavigationController, supportPackageNavigationController]
        UIApplication.topViewController()?.present(tabBarController, animated: true, completion: nil)
    }

    func back() {
        self.viewController?.dismiss(animated: true, completion: nil)
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
