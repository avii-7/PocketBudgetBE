import Vapor

func routes(_ app: Application) throws {
    
    app.get { req async in
        "It works! 🔥"
    }
    
    let group = app.grouped("api")
    
    let userRepository: any UserRespository
    let budgetRepository: any BudgetRepository
    
    if app.environment == .testing {
        userRepository = UserInMeomoryRepository()
        budgetRepository = BudgetInMemoryRepository()
    }
    else {
        userRepository = UserPostgresRepository(db: app.db)
        budgetRepository = BudgetPostgresRepository(db: app.db)
    }

    try group.register(collection: UserController(repository: userRepository))
    try group.register(collection: BudgetController(repository: budgetRepository))
}
