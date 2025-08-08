//
//  File.swift
//  PocketBudgetBE
//
//  Created by Arun's Macbook on 09/08/25.
//

import Foundation

struct BudgetMapper {
    
    static func map(from budget: Budget) -> BudgetResponse {
        BudgetResponse(
            id: budget.id ?? UUID(),
            userId: budget.userId,
            name: budget.name
        )
    }
}
