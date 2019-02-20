//
//  LogsTableViewController.swift
//  QLog
//
//  Created by Christian Oberdörfer on 02.08.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

import UIKit

protocol LogsTableViewControllerDelegate: class {

    func didSelect(_ log: URL)

}

class LogsTableViewController: UITableViewController {

    var logs: [URL] = [URL]()

    weak var delegate: LogsTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        // Register table cell class from nib
        let bundle = Bundle(identifier: "qa.quantum.QLog")!
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: bundle), forCellReuseIdentifier: "TableViewCell")
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
        self.delegate?.didSelect(self.logs[(indexPath as NSIndexPath).row])
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    // MARK: - Navigation

}
