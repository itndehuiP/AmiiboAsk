//
//  User.swift
//  AmiiboAsk
//
//  Created by ItandehuiP on 6/6/19.
//  Copyright © 2019 ItandehuiP. All rights reserved.
//

import Foundation

protocol User {
    var name: String { get set }
    var password: String { get set}
}

struct Person: User, Codable {
    
    var name : String
    var password: String

    init (name: String, password: String ) {
        self.name = name
        self.password = password
    }
    
    }
