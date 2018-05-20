//
//  LogsTableViewController.swift
//  QLog
//
//  Created by Christian Oberdörfer on 02.08.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

import UIKit

class LogsTableViewController: UITableViewController {

    var app: URL!
    var logs: [URL] = [URL]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        self.title = app?.lastPathComponent ?? ""
        // Register table cell class from nib
        let bundle = Bundle(identifier: "qa.quantum.QLog")!
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: bundle), forCellReuseIdentifier: "TableViewCell")
        // Load logs
        self.logs = {
            guard let url = self.app else {
                return []
            }
            return (try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: []).filter { !$0.hasDirectoryPath }) ?? []
        }()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.logs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let log = self.logs[(indexPath as NSIndexPath).row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell ?? TableViewCell(style: .default, reuseIdentifier: "TableViewCell")
        cell.nameLabel.text = log.lastPathComponent
        cell.separatorInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        cell.layoutMargins = UIEdgeInsets.init(top: 0, left: -15, bottom: 0, right: 15)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let archiveLogViewController = ArchiveLogViewController()
        archiveLogViewController.showLog(self.logs[(indexPath as NSIndexPath).row])
        self.show(archiveLogViewController, sender: self)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    // MARK: - Navigation

}
