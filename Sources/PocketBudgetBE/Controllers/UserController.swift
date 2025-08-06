//
//  UserController.swift
//  PocketBudgetBE
//
//  Created by Arun's Macbook on 06/08/25.
//

import Vapor

struct UserController: RouteCollection {
    
    func boot(routes: any RoutesBuilder) throws {
        let users = routes.grouped("users")
        users.get(use: getUsers)
        users.post(use: createUser)
    }
    
    private func getUsers(req: Request) async throws -> Response {
        let users = try await req.user.getUsers()
        let response = Response(status: .ok)
        try response.content.encode(users)
        return response
    }
    
    private func createUser(req: Request) async throws -> Response {
        let decodedUser = try req.content.decode(User.self)
        let user = try await req.user.createUser(decodedUser)
        let response = Response(status: .created)
        try response.content.encode(user)
        return response
    }
}
