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
    let address: String
    let address2: String
    let county: String
    let zip: String
    let areaCode: String
    let phone: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case city = "CITY"
        case address = "ADDRESS"
        case address2 = "ADDRESS2"
        case county = "County"
        case zip = "ZIP"
        case areaCode = "AREA_CODE"
        case phone = "PHONE"
    }
    
}
