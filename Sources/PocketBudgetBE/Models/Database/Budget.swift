//
//  Budget.swift
//  PocketBudgetBE
//
//  Created by Arun's Macbook on 08/08/25.
//

import Fluent
import Foundation

final class Budget: Model, @unchecked Sendable {
    
    static let schema = "budgets"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "user_id")
    var userId: UUID
    
    @Field(key: "name")
    var name: String
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, userId: UUID, name: String) {
        self.id = id
        self.userId = userId
        self.name = name
    }
}
