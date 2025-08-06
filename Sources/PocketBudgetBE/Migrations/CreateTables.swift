//
//  CreateTables.swift
//  PocketBudgetBE
//
//  Created by Arun on 29/07/25.
//

import FluentKit

struct CreateTables: AsyncMigration {
    
    func prepare(on database: any Database) async throws {
        try await database.schema(UserModel.schema)
            .id()
            .field("display_name", .string, .required)
            .field("auth_provider", .string, .required)
            .field("auth_provider_id", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        
    }
}
