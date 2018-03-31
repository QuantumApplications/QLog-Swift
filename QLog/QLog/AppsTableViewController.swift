//
//  AppsTableViewController.swift
//  QLog
//
//  Created by Christian Oberdörfer on 02.08.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

import UIKit

protocol AppsTableViewControllerDelegate: class {

    func back(_ appsTableViewController: AppsTableViewController)

}

class AppsTableViewController: UITableViewController {

    var apps: [URL] {
        guard let logUrl = UiLogger.shared?.logUrl else {
            return [URL]()
        }
        do {
            return try FileManager.default.contentsOfDirectory(at: logUrl, includingPropertiesForKeys: nil, options: []).filter { $0.hasDirectoryPath }
        } catch {
            return [URL]()
        }
    }

    weak var delegate: AppsTableViewControllerDelegate?

    init() {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
        self.tabBarItem = UITabBarItem(title: QLog.Texts.archive, image: QLog.Images.archive, tag: 2)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Register table cell class from nib
        guard let bundle = Bundle(identifier: "qa.quantum.QLog") else {
            return
        }
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: bundle), forCellReuseIdentifier: "TableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.apps.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let app = self.apps[(indexPath as NSIndexPath).row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = app.lastPathComponent
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = self.apps[(indexPath as NSIndexPath).row]
        let logsTableViewController = LogsTableViewController()
        logsTableViewController.app = app
        self.show(logsTableViewController, sender: self)
    }

    // MARK: - Navigation

    @objc func back() {
        self.delegate?.back(self)
    }

}
