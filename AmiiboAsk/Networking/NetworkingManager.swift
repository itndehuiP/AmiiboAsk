//
//  NetworkingManager.swift
//  AmiiboAsk
//
//  Created by ItandehuiP on 6/6/19.
//  Copyright © 2019 ItandehuiP. All rights reserved.
//

import Foundation

protocol NetworkingManager {
    var basePath: String { get }
}

class AmiiboApiManager: NetworkingManager {
    let basePath: String = "https://www.amiiboapi.com/api/"
    ///It defines the url
    private func getAllAmiibosPath() -> String {
        let fullPath = basePath + "amiibo"
        return fullPath
    }
    /**
    It creates the urlsession and performs the datatask
     
     - Remarks: The functionality in cases of * No Internet * has not been implemented in this version
 */
    func executeGetAllAmiibos(completion: @escaping ([ Amiibo ]) -> ()) {
        let fullURL = getAllAmiibosPath()
        let request = URLRequest(url: URL(string: fullURL)!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            var amiibos : [ Amiibo ] = [ ]
            
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    
                    if let amiibo = try jsonDecoder.decode(AmiiboMajor?.self, from: data) {
                        for amib in amiibo.amiibo! {
                            amiibos.append(amib)
                        }
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
                completion(amiibos)
            }
            
        }
        dataTask.resume()
    }
    
}
