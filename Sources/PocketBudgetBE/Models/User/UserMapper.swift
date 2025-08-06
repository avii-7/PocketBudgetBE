//
//  UserMapper.swift
//  PocketBudgetBE
//
//  Created by Arun's Macbook on 06/08/25.
//

struct UserMapper {
    
    private init() { }
    
    static func map(user: UserModel) -> User {
        User(id: user.id, displayName: user.displayName)
    }
}
