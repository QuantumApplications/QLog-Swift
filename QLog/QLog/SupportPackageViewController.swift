//
//  SupportPackageViewController.swift
//  QLog
//
//  Created by Christian Oberdörfer on 20.09.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

import UIKit

protocol SupportPackageViewControllerDelegate: class {

    func back(_ supportPackageViewController: SupportPackageViewController)
    func generateSupportPackage(_ supportPackageViewController: SupportPackageViewController)

}

class SupportPackageViewController: UIViewController {

    weak var delegate: SupportPackageViewControllerDelegate?

    init() {
        super.init(nibName: "SupportPackageViewController", bundle: Bundle(identifier: "qa.quantum.QLog")!)
        self.loadView()
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
        self.tabBarItem = UITabBarItem(title: QLog.Texts.supportPackage, image: QLog.Images.supportPackage, tag: 3)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - Navigation

    @objc func back() {
        self.delegate?.back(self)
    }

    @IBAction func generateSupportPackage(_ sender: Any) {
        self.delegate?.generateSupportPackage(self)
    }
    
}
