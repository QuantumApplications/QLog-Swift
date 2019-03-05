//
//  UIApplication.swift
//  QLog
//
//  Created by Christian Oberdörfer on 07.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

import UIKit

// Get top view controller
// Taken from https://stackoverflow.com/a/30858591/5804550
extension UIApplication {

    /**
     Returns the top view controller for given view controller
     or current root view controller.
     - parameter controller: The Controller to get the top view controller of.
     If not set, the current root view controller is used.
     - returns: The top view controller if available
     */
    public class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
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
