//
//  SupportPackageCoordinator.swift
//  QLog
//
//  Created by Christian Oberdörfer on 17.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//

import Foundation
import MobileCoreServices
import Zip

class SupportPackageCoordinator: Coordinator {

    private let navigationController: UINavigationController
    private let supportPackageViewController: SupportPackageViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.supportPackageViewController = SupportPackageViewController()
        supportPackageViewController.delegate = self
    }

    func start() {
        self.navigationController.navigationBar.topItem?.title = QLog.Texts.supportPackage
        self.navigationController.pushViewController(self.supportPackageViewController, animated: true)
    }

}

// MARK: - SupportPackageViewControllerDelegate

extension SupportPackageCoordinator: SupportPackageViewControllerDelegate {

    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
    static let targetName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "Application"

    func back(_ supportPackageViewController: SupportPackageViewController) {
        UiLogger.shared?.shown = false
        supportPackageViewController.dismiss(animated: true, completion: nil)
    }

    func generateSupportPackage(_ supportPackageViewController: SupportPackageViewController) {
        // Zip log files
        let zipDirectoryUrl = URL(fileURLWithPath: NSTemporaryDirectory())
        let zipFileUrl = zipDirectoryUrl.appendingPathComponent("Support Package \(SupportPackageCoordinator.targetName) \(SupportPackageCoordinator.dateFormatter.string(from: Date())).zip")
        let logPathUrl = UiLogger.getShared().logUrl
        guard (try? Zip.zipFiles(paths: [logPathUrl], zipFilePath: zipFileUrl, password: nil, progress: { progress in
            print(progress)
        })) != nil else {
            return
        }
        // Share zip file
        documentInteractionController = UIDocumentInteractionController()
        documentInteractionController.url = zipFileUrl
        documentInteractionController.uti = String(kUTTypeZipArchive)
        documentInteractionController.presentOptionsMenu(from: supportPackageViewController.view.frame, in: supportPackageViewController.view, animated: true)
    }

}
