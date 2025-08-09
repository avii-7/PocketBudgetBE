//
//  CreateTables.swift
//  PocketBudgetBE
//
//  Created by Arun on 29/07/25.
//

import FluentKit

struct CreateTables: AsyncMigration {
    
    func prepare(on database: any Database) async throws {
        
        try await database.schema(User.schema)
            .id()
            .field("display_name", .string, .required)
            .field("auth_provider", .string, .required)
            .field("auth_provider_id", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .create()
        
        try await database.schema(Budget.schema)
            .id()
            .field("user_id", .uuid, .references(User.schema, "id"))
            .field("name", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        
    }
}
