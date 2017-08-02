//
//  AppsTableViewController.swift
//  LogViewer
//
//  Created by Christian Oberdörfer on 02.08.17.
//  Copyright © 2017 QuineSoft. All rights reserved.
//

import UIKit

class AppsTableViewController: UITableViewController {
    
    let apps: [URL] = {
        guard let url = LogViewer.logUrl else {
            return [URL]()
        }
        do {
            return try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: []).filter({ $0.hasDirectoryPath })
        }
        catch {
            return [URL]()
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register table cell class from nib
        guard let bundle = Bundle(identifier: "de.quinesoft.LogViewer") else {
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
        guard let bundle = Bundle(identifier: "de.quinesoft.LogViewer") else {
            return
        }
        let logsTableViewController = LogsTableViewController(nibName: "LogsTableViewController", bundle: bundle)
        logsTableViewController.app = app
        self.show(logsTableViewController, sender: self)
    }
    
    // MARK: - Navigation
    
}
