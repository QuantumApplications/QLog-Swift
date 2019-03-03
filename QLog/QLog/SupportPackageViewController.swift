//
//  SupportPackageViewController.swift
//  QLog
//
//  Created by Christian Oberdörfer on 20.09.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

import UIKit

protocol SupportPackageViewControllerDelegate: class {

    func back()
    func generateSupportPackage()

}

class SupportPackageViewController: UIViewController {

    @IBOutlet weak var generateSupportPackageButton: UIButton!
    weak var delegate: SupportPackageViewControllerDelegate?

    init() {
        super.init(nibName: "SupportPackageViewController", bundle: Bundle(identifier: "qa.quantum.QLog")!)
        self.loadView()
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
        // Localization
        self.generateSupportPackageButton.setTitle(QLog.Texts.generateSupportPackage, for: .normal)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: - Navigation

    @objc func back() {
        self.delegate?.back()
    }

    @IBAction func generateSupportPackage(_ sender: Any) {
        self.delegate?.generateSupportPackage()
    }

}
