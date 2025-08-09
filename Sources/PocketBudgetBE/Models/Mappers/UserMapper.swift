//
//  UserMapper.swift
//  PocketBudgetBE
//
//  Created by Arun's Macbook on 06/08/25.
//

struct UserMapper {
    
    private init() { }
    
    static func map(from user: User) -> UserResponse {
        UserResponse(id: user.id, displayName: user.displayName)
    }
}
