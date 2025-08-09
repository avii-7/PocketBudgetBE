//
//  UserPostgresRepository.swift
//  PocketBudgetBE
//
//  Created by Arun on 08/06/25.
//

import Foundation
import Vapor
import FluentKit

protocol UserRespository: Sendable {
    
    func getUsers() async throws -> [UserResponse]
    
    func getUser(id: UUID) async throws -> UserResponse?
    
    func createUser(_ user: NewUserRequest) async throws -> UserResponse
    
    func deleteUser(by id: UUID) async throws
}

// https://theswiftdev.com/the-repository-pattern-for-vapor-4/
final class UserPostgresRepository: UserRespository {
    
    private let db: any Database
    
    init(db: any Database) {
        self.db = db
    }
    
    private func query() -> QueryBuilder<User> {
        db.query(User.self)
    }
    
    func createUser(_ user: NewUserRequest) async throws -> UserResponse {
        let user = User(
            displayName: user.name,
            authProvider: "test",
            authProviderId: "test"
        )
        try await user.create(on: db)
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
