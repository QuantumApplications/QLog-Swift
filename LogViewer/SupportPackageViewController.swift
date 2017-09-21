//
//  SupportPackageViewController.swift
//  LogViewer
//
//  Created by Christian Oberdörfer on 20.09.17.
//  Copyright © 2017 QuineSoft. All rights reserved.
//

import UIKit

protocol SupportPackageViewControllerDelegate: class {

    func back(_ supportPackageViewController: SupportPackageViewController)

}

class SupportPackageViewController: UIViewController {

    weak var delegate: SupportPackageViewControllerDelegate?

    init() {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
        self.tabBarItem = UITabBarItem(title: "Support Package", image: UIImage(), tag: 3)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation

    func back() {
        self.delegate?.back(self)
    }

}
