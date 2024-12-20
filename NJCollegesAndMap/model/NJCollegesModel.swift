//
//  NJCollegesModel.swift
//  NJCollegesAndMap
//
//  Created by Anjali Narang  on 10/12/24.
//

import Foundation

struct College: Codable {
    var coordinates: [Double]
    var id: Int
    var name: String
    var city: String
    var address: String
    var address2: String
    var county: String
    var zip: String
    var areaCode: String
    var phone: String
}

class NJCollegesModel {
    
    let logoAssetNames : [String] = ["rutgers","monmouth","stevens","drew","njinstitute","newjerseycityuniversity","talmudical","berkeley","rowancollege","rowan","princeton","montclair","kean","fairleigh","phoenix","atlanticcape","brookdale","setonhall","rabbinical","oceancountycollege","thomasedison","georgiancourt","felician","passaic","centenary","caldwell","bloomfield","warren","sussex","salem","raritanvalley","countycollegeofmorris","middlesex","hudson","mercer","essex","burlington","rider","ramapo","thecollegeofnewjersey","saintpeter","rabbijacob","newbrunswicktheological","devry","bethmedrash","assumption","saintelizabeth","union","cumberland","camden","bergen","williampatterson","therichardstocktoncollegeofnewjersey","pillar"]
    
    var njColleges: [College] = []
    static let sharedInstance = NJCollegesModel()
    
    let collegesURL:String = "https://ios-api.csse-projects.monmouth.edu/data?file=NJColleges"
        
    private init () {
        //readCollegesData()
        print("in init")
        Task {
            let result = try await fetchCollegesAsync()
            if result {
                print ("data from api", njColleges.count)
            } else {
                print ("No data from API")
            }
        }
    }
    
    func getColleges() -> [College] {
        return self.njColleges
    }
    
    func getCollege(findId: Int) -> College? {
        if let college = njColleges.first(where: {$0.id == findId}) {
            return college
        } else {
            return nil
        }
    }
    
    func fetchCollegesAsync() async throws -> Bool {
        
        guard let url = URL(string: collegesURL) else {
            throw CollegesFetchError.invalidURL
        }
        
        do {
            
            let (jsonData, urlResponse) = try await URLSession.shared.data(from: url)
    
            let code = (urlResponse as? HTTPURLResponse)?.statusCode
            guard code == 200 else { // 200 = OK
                throw CollegesFetchError.missingData
            }
                    
            let features = try! JSONDecoder().decode([Feature].self, from: jsonData)
            
            for feature in features {
                
                // create college from featue
                
                let currentCollege = College(
                    coordinates: feature.geometry.coordinates,
                    id: feature.id,
                    name: feature.properties.name,
                    city: feature.properties.city,
                    address: feature.properties.address,
                    address2: feature.properties.address2,
                    county: feature.properties.county,
                    zip: feature.properties.zip,
                    areaCode: feature.properties.areaCode,
                    phone: feature.properties.phone
                )
                
                self.njColleges.append(currentCollege) // add to list
                
            }
            print(njColleges.count)
            
            //njColleges = try JSONDecoder().decode([College].self, from: data)
            return true
            
        } catch { // missing data
            print("Error fetching colleges: \(error)")
            return false
        }
        
    }
    
    func readCollegesData() {
        
        if let filename = Bundle.main.path(forResource: "NJColleges", ofType: "json") {
            
            do {
                
                let jsonStr  = try String (contentsOfFile: filename, encoding: .utf8)
                let jsonData = jsonStr.data(using: .utf8)!
                
                // decode features (top level object)
                let features = try! JSONDecoder().decode([Feature].self, from: jsonData)
                
                for feature in features {
                    
                    // create college from featue
                    
                    let currentCollege = College(
                        coordinates: feature.geometry.coordinates,
                        id: feature.id,
                        name: feature.properties.name,
                        city: feature.properties.city,
                        address: feature.properties.address,
                        address2: feature.properties.address2,
                        county: feature.properties.county,
                        zip: feature.properties.zip,
                        areaCode: feature.properties.areaCode,
                        phone: feature.properties.phone
                    )
                    
                    self.njColleges.append(currentCollege) // add to list
                    
                }
                
            }
            
            catch { print("The file could not be loaded") }
            
        }
        
        else { print ("The file could not be found") }
        
    }

    func getImage(collegeName: String) -> String {
        
        var asset: String
        let searchString = collegeName.lowercased().replacingOccurrences(of: " ", with: "")

        for assetName in logoAssetNames {
            
            if (searchString.contains(assetName)) {
                // found
                asset = assetName
                return asset
            }
            
        }
        
        // not found
        asset = "default_uni"
        return asset

    }
    
    func getSummaryValues() -> [Int] {
        
        let totalColleges = njColleges.count
        let northColleges = njColleges.filter { $0.coordinates[1] > 40.47368 }.count
        let centralColleges = njColleges.filter { $0.coordinates[1] >= 39.95219 && $0.coordinates[1] <= 40.47378 }.count
        let southColleges = njColleges.filter { $0.coordinates[1] < 39.95219 }.count
        
        return [totalColleges,northColleges,centralColleges,southColleges]
        
    }
    
    func formatAddress(input: String) -> String {

        let words = input.split(separator: " ")
        var result = [String]()

        for word in words {
            let capitalizedWord = word.prefix(1).uppercased() + word.dropFirst().lowercased()
            result.append(capitalizedWord)
        }

        return result.joined(separator: " ")
        
    }
    
}

enum CollegesFetchError: Error {
    case invalidURL
    case missingData
}
