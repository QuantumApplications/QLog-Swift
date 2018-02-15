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
        self.title = app.lastPathComponent
        // Register table cell class from nib
        guard let bundle = Bundle(identifier: "qa.quantum.QLog") else {
            return
        }
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: bundle), forCellReuseIdentifier: "TableViewCell")
        // Load logs
        self.logs = {
            guard let url = self.app else {
                return [URL]()
            }
            do {
                return try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: []).filter { !$0.hasDirectoryPath }
            } catch {
                return [URL]()
            }
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
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = log.lastPathComponent
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let logViewController = LogViewController()
        logViewController.showLog(self.logs[(indexPath as NSIndexPath).row])
        self.show(logViewController, sender: self)
    }

    // MARK: - Navigation

}
