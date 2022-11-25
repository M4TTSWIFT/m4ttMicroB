//
//  ShowsModel.swift
//  m4ttMicroB
//
//  Created by Mac on 19.11.2022.
//

import Foundation

public struct ShowsModel: Codable {
    
    var _embedded: Embedded
    
    struct Embedded: Codable {
        var show: Show
    }
    
    struct Show: Codable {
        var id: Int
        var name: String
        var genres: [String]
        var rating: Rating?
        var image: Image?
        
    }
    
    struct Rating: Codable {
        var average: Double?
    }
    
    struct Image: Codable {
        var medium: String?
    }
}
