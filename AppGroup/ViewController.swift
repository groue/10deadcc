import UIKit
import GRDB

class ViewController: UIViewController {
    
    @IBOutlet private var runLongTransactionButton: UIButton!
    @IBOutlet private var runLongQueryButtonInDatabaseQueue: UIButton!
    @IBOutlet private var runLongQueryButtonInDatabasePool: UIButton!

    @IBAction func runLongTransaction() {
        isEnabled = false
        
        try! AppDatabase.shared.createDatabasePool()
        AppDatabase.shared.openLongRunningTransaction { result in
            self.isEnabled = true
        }
    }
    
    @IBAction func runLongQueryInDatabaseQueue() {
        isEnabled = false

        try! AppDatabase.shared.createDatabaseQueue()
        AppDatabase.shared.runLongQuery { result in
            self.isEnabled = true
        }
    }
    
    @IBAction func runLongQueryInDatabasePool() {
        isEnabled = false

        try! AppDatabase.shared.createDatabasePool()
        AppDatabase.shared.runLongQuery { result in
            self.isEnabled = true
        }
    }

    private var isEnabled = true {
        didSet {
            runLongTransactionButton.isEnabled = isEnabled
            runLongQueryButtonInDatabaseQueue.isEnabled = isEnabled
            runLongQueryButtonInDatabasePool.isEnabled = isEnabled
        }
    }
}
