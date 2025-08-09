//
//  BudgetRespository.swift
//  PocketBudgetBE
//
//  Created by Arun's Macbook on 09/08/25.
//

import Vapor
import Fluent
import Foundation

protocol BudgetRepository: Sendable {
    
    func create(_ budget: NewBudgetRequest) async throws -> BudgetResponse
    
    func getAll(_ userId: UUID) async throws -> [BudgetResponse]
}

struct BudgetPostgresRepository: BudgetRepository {
    
    private let db: any Database
    
    init(db: any Database) {
        self.db = db
    }
    
    private func query() -> QueryBuilder<Budget> {
        return db.query(Budget.self)
    }
    
    func create(_ budget: NewBudgetRequest) async throws -> BudgetResponse {
        let budget = Budget(userId: budget.userId, name: budget.name)
        try await budget.create(on: db)
        return BudgetMapper.map(from: budget)
    }
    
    func getAll(_ userId: UUID) async throws -> [BudgetResponse] {
        let budgets = try await query().filter(\.$userId == userId).all()
        return budgets.map(BudgetMapper.map(from:))
    }
}
