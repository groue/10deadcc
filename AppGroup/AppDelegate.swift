import UIKit
import GRDB
import os.log

// The shared database queue
var dbQueue: DatabaseQueue!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        try! setupDatabase(application)
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
        let task = application.beginBackgroundTask {
            os_log("%@", "end of background task")
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        os_log("%@", #function)
    }
    
    private func setupDatabase(_ application: UIApplication) throws {
        let databaseURL = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.com.github.groue.AppGroup")!
            .appendingPathComponent("db.sqlite")
        dbQueue = try AppDatabase.openDatabase(atPath: databaseURL.path)
        
        // Be a nice iOS citizen, and don't consume too much memory
        // See https://github.com/groue/GRDB.swift/blob/master/README.md#memory-management
        dbQueue.setupMemoryManagement(in: application)
    }
}
