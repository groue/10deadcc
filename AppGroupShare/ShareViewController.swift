//
//  ShareViewController.swift
//  AppGroupShare
//
//  Created by Gwendal Roué on 30/11/2019.
//  Copyright © 2019 Gwendal Roué. All rights reserved.
//

import UIKit
import Social
import GRDB
import os.log

class ShareViewController: SLComposeServiceViewController {
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
        
        try! AppDatabase.shared.createDatabaseQueue()
        AppDatabase.shared.openLongRunningTransaction { result in
            os_log("%@", "result: \(result)")
        }
        
        let semaphore = DispatchSemaphore(value: 0)
        ProcessInfo.processInfo.performExpiringActivity(withReason: "check") { suspended in
            os_log("%@", "suspended: \(suspended)")
            if suspended {
                semaphore.signal()
            } else {
                semaphore.wait()
            }
        }
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
