//
//  UserInMeomoryRepository.swift
//  PocketBudgetBE
//
//  Created by Arun on 08/06/25.
//

import Foundation

actor UserInMeomoryRepository: UserRespository {
    
    private var users: [UserResponse]
    
    init(users: [UserResponse] = []) {
        self.users = users
    }
    
    func getUsers() async throws -> [UserResponse] {
        users
    }
    
    func getUser(id: UUID) async throws -> UserResponse? {
        users.first { $0.id == id }
    }
    
    func createUser(_ user: NewUserRequest) async throws -> UserResponse {
        let user = UserResponse(id: UUID(), displayName: user.name)
        users.append(user)
        return user
    }
    
    func deleteUser(by id: UUID) async throws {
        users.removeAll { $0.id == id }
    }
}
