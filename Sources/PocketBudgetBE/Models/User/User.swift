//
//  UserModel.swift
//  PocketBudgetBE
//
//  Created by Arun on 25/07/25.
//

import Foundation

struct User: Codable {
    
    let id: UUID
    
    let displayName: String
    
    let authProvider: String
    
    let authProviderId: String
}
