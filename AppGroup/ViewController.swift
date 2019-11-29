import UIKit
import GRDB

class ViewController: UIViewController {
    
    @IBOutlet private var button: UIButton!

    @IBAction func runTransaction() {
        button.isEnabled = false
        
        let semaphore = DispatchSemaphore(value: 0)
        
        DispatchQueue.global().async {
            try! dbQueue.inTransaction(.immediate) { _ in
                semaphore.wait()
                return .commit
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(60)) {
            semaphore.signal()
            self.button.isEnabled = true
        }
    }
}
