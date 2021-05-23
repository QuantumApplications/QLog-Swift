//
//  AppsTableViewController.swift
//  QLog
//
//  Created by Christian Oberdörfer on 02.08.17.
//  Copyright © 2017 Quantum. All rights reserved.
//

import UIKit

protocol AppsTableViewControllerDelegate: AnyObject {

    /// Goes back
    func back()
    /// Shows log files of an application target
    func show(_ app: URL)

}

class AppsTableViewController: UITableViewController {

    var apps: [URL] = [URL]()

    weak var delegate: AppsTableViewControllerDelegate?

    init() {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

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
        return self.apps.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let app = self.apps[(indexPath as NSIndexPath).row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = app.lastPathComponent
        cell.separatorInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        cell.layoutMargins = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 15)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = self.apps[(indexPath as NSIndexPath).row]
        self.delegate?.show(app)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    // MARK: - Navigation

    @objc func back() {
        self.delegate?.back()
    }

}
