//
//  UserPostgresRepository.swift
//  PocketBudgetBE
//
//  Created by Arun on 08/06/25.
//

import Foundation
import Vapor
import FluentKit

protocol UserRespository {
    
    func getUsers() async throws -> [UserResponse]
    
    func getUser(id: UUID) async throws -> UserResponse?
    
    func createUser(_ user: UserResponse) async throws -> UserResponse
    
    func deleteUser(by id: UUID) async throws
}

// https://theswiftdev.com/the-repository-pattern-for-vapor-4/
final class UserPostgresRepository: UserRespository {
    
    private let request: Request
    
    init(request: Request) {
        self.request = request
    }
    
    private func query() -> QueryBuilder<User> {
        User.query(on: request.db)
    }
    
    func createUser(_ user: UserResponse) async throws -> UserResponse {
        let user = User(
            id: user.id,
            displayName: user.displayName,
            authProvider: "test",
            authProviderId: "test"
        )
        try await user.create(on: request.db)
        return UserMapper.map(from: user)
    }
        
    func getUsers() async throws -> [UserResponse] {
        try await query().all().map { UserMapper.map(from: $0) }
    }
    
    func getUser(id: UUID) async throws -> UserResponse? {
        try await query()
            .filter(\.$id == id)
            .first()
            .map { UserMapper.map(from: $0) }
    }
    
    func deleteUser(by id: UUID) async throws {
        try await query()
            .filter(\.$id == id)
            .delete()
    }
}
