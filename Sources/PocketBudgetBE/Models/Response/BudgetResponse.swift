//
//  BudgetResponse.swift
//  PocketBudgetBE
//
//  Created by Arun's Macbook on 09/08/25.
//

import Vapor

struct NewBudget {
    let userId: UUID
    let name: String
}

struct BudgetResponse: Content {
    
    let id: UUID
    
    let userId: UUID
    
    let name: String
}
