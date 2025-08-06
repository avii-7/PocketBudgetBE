//
//  User.swift
//  PocketBudgetBE
//
//  Created by Arun on 25/07/25.
//

import Foundation
import Fluent

final class UserModel: Model, @unchecked Sendable {
    
    static let schema = "UserModel"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "display_name")
    var displayName: String
    
    @Field(key: "auth_provider")
    var authProvider: String
    
    @Field(key: "auth_provider_id")
    var authProviderId: String
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, displayName: String, authProvider: String, authProviderId: String) {
        self.id = id
        self.displayName = displayName
        self.authProvider = authProvider
        self.authProviderId = authProviderId
    }
}
