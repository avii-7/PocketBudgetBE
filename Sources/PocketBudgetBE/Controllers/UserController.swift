//
//  UserController.swift
//  PocketBudgetBE
//
//  Created by Arun's Macbook on 06/08/25.
//

import Vapor

struct UserController: RouteCollection, Sendable {
    
    private let repository: any UserRespository
    
    init(repository: any UserRespository) {
        self.repository = repository
    }
    
    func boot(routes: any RoutesBuilder) throws {
        let users = routes.grouped("users")
        users.get(use: getUsers)
        users.post(use: createUser)
        users.delete(use: deleteUser)
    }
    
    
    private func getUsers(req: Request) async throws -> Response {
        let users = try await repository.getUsers()
        let response = Response(status: .ok)
        try response.content.encode(users)
        return response
    }
    
    private func createUser(req: Request) async throws -> Response {
        let decodedUser = try req.content.decode(UserResponse.self)
        let user = try await repository.createUser(decodedUser)
        let response = Response(status: .created)
        try response.content.encode(user)
        return response
    }
    
    private func deleteUser(req: Request) async throws -> Response {
        let body = try req.content.decode([String: String].self)

        guard
            let userId = body["id"],
            let userUUID = UUID(uuidString: userId) else {
            return Response(status: .badRequest)
        }
        
        try await repository.deleteUser(by: userUUID)
        return Response(status: .ok)
    }
}
