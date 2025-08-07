//
//  UserRespository.swift
//  PocketBudgetBE
//
//  Created by Arun on 08/06/25.
//

import Foundation

protocol UserRespository {
    
    func getUsers() async throws -> [User]
    
    func getUser(id: UUID) async throws -> User?
    
    func createUser(_ user: User) async throws -> User
    
    func deleteUser(by id: UUID) async throws
}
