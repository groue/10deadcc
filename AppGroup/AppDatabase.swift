import GRDB

struct AppDatabase {
    static func openDatabase(atPath path: String) throws -> DatabaseQueue {
        var configuration = Configuration()
        configuration.trace = {
            print("SQL>", $0)
        }
        let dbQueue = try DatabaseQueue(path: path, configuration: configuration)
        try migrator.migrate(dbQueue)
        return dbQueue
    }
    
    static var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        migrator.registerMigration("createPlayer") { db in
            try db.create(table: "player") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("name", .text).notNull()
                t.column("score", .integer).notNull()
            }
        }
        return migrator
    }
}
