//
//  ModelStructs.swift
//  NJCollegesAndMap
//
//  Created by Anjali Narang  on 10/12/24.
//

// structures to match JSON

struct Feature: Codable {
    let id: Int
    let properties: Properties
    let geometry: Geometry
}

struct Geometry: Codable {
    let coordinates: [Double]
}

struct Properties: Codable {
    
    let name: String
    let city: String
    let county: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case city = "Municipali"
        case county = "County"
    }
    
}
