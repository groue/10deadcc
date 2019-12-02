import UIKit
import GRDB
import os.log

// The shared database queue
var dbQueue: DatabaseQueue!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        os_log("%@", #function)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        os_log("%@", #function)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        os_log("%@", #function)
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
    
    func applicationWillTerminate(_ application: UIApplication) {
        os_log("%@", #function)
    }
}
