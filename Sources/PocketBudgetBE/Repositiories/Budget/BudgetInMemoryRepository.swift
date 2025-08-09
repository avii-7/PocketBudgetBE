//
//  BudgetInMemoryRepository.swift
//  PocketBudgetBE
//
//  Created by Arun's Macbook on 09/08/25.
//

import Foundation

actor BudgetInMemoryRepository: BudgetRepository {
    
    private var budgets: [BudgetResponse]
    
    init(budgets: [BudgetResponse] = []) {
        self.budgets = budgets
    }
    
    func create(_ budget: NewBudgetRequest) async throws -> BudgetResponse {
        let newBudget = BudgetResponse(
            id: UUID(),
            userId: budget.userId,
            name: budget.name
        )
        
        budgets.append(newBudget)
        return newBudget
    }
    
    func getAll(_ userId: UUID) async throws -> [BudgetResponse] {
        budgets.filter { $0.userId == userId }
    }
}
