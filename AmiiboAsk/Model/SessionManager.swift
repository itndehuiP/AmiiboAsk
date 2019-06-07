//
//  SessionManagement.swift
//  AmiiboAsk
//
//  Created by ItandehuiP on 6/6/19.
//  Copyright © 2019 ItandehuiP. All rights reserved.
//

import Foundation

class SessionManager {
    
    static let shared = SessionManager()
    private var userDefault = Person(name: "test@mail.com", password: "test123")
    
    var user: User = Person(name: "", password: "")
    var logged : Bool = false
    
    private init() {
        self.logged = loadUser()
    }
    
    /// It validates the credentials
    func validateData() -> Bool {
        if user.name == userDefault.name && user.password == userDefault.password {
            writeUser()
            logged = true
            return true
        } else {
            return false
        }
    }
    ///It confirms that the data has been fullfilled
    func didFilledData() -> Bool {
        if user.name != "" && user.password != "" {
            return true
        } else {
            return false
        }
    }
    ///It configure the path for save the data
    private func configurePath() -> URL {
        let filename = "sessionConfiguration"
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fullPath = paths[0].appendingPathComponent(filename)
        return fullPath
    }
    ///It load the data saved
    func loadUser() -> Bool {
        let fullPath = configurePath()
        do {
            let data = try Data.init(contentsOf: fullPath)
            if let sessionOwner = try PropertyListDecoder().decode(Person?.self, from: data) {
                self.user = sessionOwner
                return true
            }
            else {
                print("There's no saved session")
            }
        } catch {
            print("Couldn't read file")
        }
        return false
        
    }
    /// It write the data into the file
    func writeUser() {
         let fullPath = configurePath()
        do {
            let sessionOwner = Person(name: user.name, password: user.password)
            let data = try PropertyListEncoder().encode(sessionOwner)
            try data.write(to: fullPath)
        } catch {
            print("Couldn't write file")
        }
    }
    ///It reset session
    func resetSession() {
        let fullPath = configurePath()
            do {
                logged = false
                user = Person(name: "", password: "")
                try FileManager.default.removeItem(at: fullPath)
            } catch {
                print("Couldn't find path")
            }
    }
}
