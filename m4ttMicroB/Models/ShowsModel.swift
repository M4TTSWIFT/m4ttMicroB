//
//  ShowsModel.swift
//  m4ttMicroB
//
//  Created by Mac on 19.11.2022.
//

import Foundation

struct ShowsModel: Codable {
    
    var id: Int
    var name: String
    var season: Int?
    var number: Int?
    var runtime: Int?
    var rating: Rating?
    var image: Image?
}

struct Rating: Codable {
    var average: Double?
}

struct Image: Codable {
    var medium: String?
}
