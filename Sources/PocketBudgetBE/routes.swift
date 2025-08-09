import Vapor

func routes(_ app: Application) throws {
    
    app.get { req async in
        "It works! 🔥"
    }
    
    // TODO: - Try to use app.db to create repos.
    let group = app.grouped("api")
    
    let userRepository = UserPostgresRepository(db: app.db)
    try group.register(collection: UserController(repository: userRepository))
    
    let budgetRepository = BudgetPostgresRepository(db: app.db)
    try group.register(collection: BudgetController(repository: budgetRepository))
}
