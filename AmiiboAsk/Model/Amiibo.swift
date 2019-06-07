//
//  Amiibo.swift
//  AmiiboAsk
//
//  Created by ItandehuiP on 6/6/19.
//  Copyright © 2019 ItandehuiP. All rights reserved.
//

import Foundation

struct Amiibo: Codable {
    let amiiboSeries: String?
    let character: String?
    let gameSeries: String?
    let head: String?
    let image: String?
    let name: String?
    let release : Release?
    let tail: String?
    let type: String?
    
    func validate(par: String?) -> String {
        if par == nil {
            return "No hay información"
        } else {
            return par!
        }
    }
}

extension Amiibo: CustomStringConvertible {
    var description: String {
        return """
        Nombre: \(validate(par: name))
        Amiibo Serie: \(validate(par: amiiboSeries))
        Character: \(validate(par: character))
        Game serie: \(validate(par: gameSeries))
        Head: \(validate(par: head))
        Release:
        \(validate(par: release?.description))
        Tail: \(validate(par: tail))
        Type: \(validate(par: type))
        """
    }
    
    
}

struct Release: Codable {
    let au: String?
    let eu: String?
    let jp: String?
    let na: String?
    
    func validate(par: String?) -> String {
        if par == nil {
            return "No hay información"
        } else {
            return par!
        }
    }
}

extension Release: CustomStringConvertible {
    var description: String {
       return """
        Australia: \(validate(par: au))
        Estados Unidos: \(validate(par: eu))
        Japón: \(validate(par: jp))
        Namibia: \(validate(par: na))
        """
    }
}
