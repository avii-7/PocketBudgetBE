//
//  BudgetRespository.swift
//  PocketBudgetBE
//
//  Created by Arun's Macbook on 09/08/25.
//

import Vapor
import Fluent

protocol BudgetRespository {
    
}

struct BudgetPostgresRepository: BudgetRespository {
    
    private let request: Request
    
    init(request: Request) {
        self.request = request
    }
    
    private func query() -> QueryBuilder<Budget> {
        Budget.query(on: request.db)
    }
    
    func createBudget(_ budget: NewBudget) async throws -> BudgetResponse {
        let budget = Budget(
            userId: budget.userId,
            name: budget.name
        )
        
        try await budget.create(on: request.db)
        return BudgetMapper.map(from: budget)
    }
}
