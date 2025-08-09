//
//  BudgetControllerTests.swift
//  PocketBudgetBE
//
//  Created by Arun's Macbook on 09/08/25.
//

import Testing
import VaporTesting
@testable import PocketBudgetBE

@Suite("BudgetController Tests", .serialized)
struct BudgetControllerTests {
    
    @Test
    func createBudget() async throws {

        try await withApp(configure: configure) { app in
            
            let userId = UUID()
            let budgetName = "Car Rent"
            
            try await app.testing().test(.POST, "api/budgets") { request in
                let budgetRequest = NewBudgetRequest(userId: userId, name: budgetName)
                try request.content.encode(budgetRequest)
            } afterResponse: { response in
                #expect(response.status == .created)
                let budgetResponse = try response.content.decode(BudgetResponse.self)
                #expect(budgetResponse.name == budgetName)
                #expect(budgetResponse.userId == userId)
            }
        }
    }
    
    @Test
    func getBudget() async throws {

        try await withApp(configure: configure) { app in
            
            let userId = UUID()
            let budgetName = "Room Rent"
            
            try await app.testing().test(.POST, "api/budgets") { request in
                let budgetRequest = NewBudgetRequest(userId: userId, name: budgetName)
                try request.content.encode(budgetRequest)
            } afterResponse: { response in
                #expect(response.status == .created)
                let budgetResponse = try response.content.decode(BudgetResponse.self)
                #expect(budgetResponse.name == budgetName)
                #expect(budgetResponse.userId == userId)
            }
            
            try await app.testing().test(.GET, "api/budgets/\(userId)") { res in
                #expect(res.status == .ok)
                let budgetResponses = try res.content.decode([BudgetResponse].self)
                
                guard let budgetResponse = budgetResponses.first else {
                    Issue.record("Should be one budget")
                    return
                }
                
                #expect(budgetResponse.name == budgetName)
                #expect(budgetResponse.userId == userId)
            }
        }
    }
}
