//
//  BudgetController.swift
//  PocketBudgetBE
//
//  Created by Arun's Macbook on 09/08/25.
//

import Vapor

struct BudgetController: RouteCollection, Sendable {
    
    private let repository: any BudgetRepository
    
    init(repository: any BudgetRepository) {
        self.repository = repository
    }
    
    func boot(routes: any RoutesBuilder) throws {
        let budgets = routes.grouped("budgets")
        
        budgets.get(
            .parameter(ParameterConstant.userId.pathValue),
            use: getBudgets(_:)
        )
        
        budgets.post(use: createBudget)
    }
    
    private func createBudget(_ req: Request) async throws -> Response {
        let budgetRequest = try req.content.decode(NewBudgetRequest.self)
        let result = try await repository.create(budgetRequest)
        let response = Response(status: .created)
        try response.content.encode(result)
        return response
    }
    
    private func getBudgets(_ req: Request) async throws -> Response {
        
        guard
            let userId = req.parameters.get(ParameterConstant.userId.pathValue),
            let userUUID = UUID(uuidString: userId) else {
            return Response(status: .badRequest)
        }
        
        let budgets = try await repository.getAll(userUUID)
        let response = Response(status: .ok)
        try response.content.encode(budgets)
        return response
    }
}
