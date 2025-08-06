//
//  UserModel.swift
//  PocketBudgetBE
//
//  Created by Arun on 25/07/25.
//

import Foundation
import Vapor

struct User: Content {
    
    let id: UUID?
    
    let displayName: String
}
