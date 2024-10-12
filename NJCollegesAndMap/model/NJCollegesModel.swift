//
//  NJCollegesModel.swift
//  NJCollegesAndMap
//
//  Created by Anjali Narang  on 10/12/24.
//

import Foundation

struct College:Codable {

    var coordinates:[Float]
    var id:Int
    var name:String
    var city:String
    var county:String

    
    enum CodingKeys: String, CodingKey {
    
        case coordinates = "coordinates"
        case id = "OBJECTID"
        case name = "Name"
        case city = "Municipali"
        case county = "County"
    
    }
    
}


class NJCollegesModel {
    
    var njColleges:[College] = []
    static let sharedInstance = NJCollegesModel()
        
    private init () {
        readCollegesData()
    }
    
    func readCollegesData() {
        
        if let filename = Bundle.main.path(forResource: "NJColleges", ofType: "json") {
            
            do {
                let jsonStr  = try String (contentsOfFile: filename, encoding: .utf8)
                let jsonData = jsonStr.data(using: .utf8)!
                //njColleges = try JSONDecoder().decode([College].self, from: jsonData)
                njColleges = try! JSONDecoder().decode([College].self, from: jsonData)
            }
            
            catch {
                print("The file could not be loaded")
            }
            
        } else {
            print ("The file could not be found")
        }
        
    }
    
    func getColleges() -> [College] {
        return self.njColleges
    }
    
}
