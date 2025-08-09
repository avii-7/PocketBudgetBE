import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    
    app.databases.use(
        .postgres(
            configuration: .init(
                hostname: "localhost",
                port: 5432,
                username: "postgres",
                password: "postgres",
                database: "pocket_budget",
                tls: .disable
            )
        ),
        as: .psql
    )
    
    app.migrations.add(CreateTables())
    
    try routes(app)
}
