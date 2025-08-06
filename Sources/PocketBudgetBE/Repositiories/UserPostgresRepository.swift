//
//  UserPostgresRepository.swift
//  PocketBudgetBE
//
//  Created by Arun on 08/06/25.
//

import Foundation
import Vapor
import FluentKit

// https://theswiftdev.com/the-repository-pattern-for-vapor-4/
final class UserPostgresRepository: UserRespository {
    
    private let request: Request
    
    init(request: Request) {
        self.request = request
    }
    
    private func query() -> QueryBuilder<UserModel> {
        UserModel.query(on: request.db)
    }
        
    func getUsers() async throws -> [User] {
        try await query().all().map { UserMapper.map(user: $0) }
    }
    
    func getUser(id: UUID) async throws -> User? {
        try await query()
            .filter(\.$id == id)
            .first()
            .map { UserMapper.map(user: $0) }
    }
    
    func createUser(_ user: User) async throws -> User {
        let userModel = UserModel(
            id: user.id,
            displayName: user.displayName,
            authProvider: "test",
            authProviderId: "test"
        )
        try await userModel.create(on: request.db)
        return UserMapper.map(user: userModel)
    }
}
