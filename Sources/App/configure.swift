import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    if let databaseUrl = Environment.get("DATABASE_URL") {
        app.databases.use(try .postgres(
            url: databaseUrl
        ), as: .psql)
    }
    app.migrations.add(CreatePlace(), CreateOrder())
    
    // register routes
    try routes(app)

    try app.autoMigrate().wait()
}
