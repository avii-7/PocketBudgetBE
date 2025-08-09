//
//  UserResponse.swift
//  PocketBudgetBE
//
//  Created by Arun on 25/07/25.
//

import Vapor

struct UserResponse: Content {
    
    let id: UUID?
    
    let displayName: String
}
