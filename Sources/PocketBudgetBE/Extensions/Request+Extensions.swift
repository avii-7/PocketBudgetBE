//
//  File.swift
//  PocketBudgetBE
//
//  Created by Arun's Macbook on 06/08/25.
//

import Foundation
import Vapor

extension Request {
    
//    var user: any UserRespository {
//        UserPostgresRepository(request: self)
//    }
    
//    var budget: any BudgetRespository {
//        BudgetPostgresRepository(request: self)
//    }
}

enum ParameterConstant: String {
    case userId
    
    var pathValue: String {
        ":\(rawValue)"
    }
}
