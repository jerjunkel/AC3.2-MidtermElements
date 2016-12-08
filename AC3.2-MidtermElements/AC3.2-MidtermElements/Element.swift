//
//  Element.swift
//  AC3.2-MidtermElements
//
//  Created by Jermaine Kelly on 12/8/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import Foundation

class Element{
    let id: Int?
    let recordUrl: String
    let name: String
    let number: Int?
    let weight: Float?
    let symbol: String
    let meltingPoint:Int?
    let boilingPoint:Int?
    let density : Float?
    let crustPercent:Float?
    let discoveryYear: String
    let group: Int?
    let electrons: String
    let ionEnergy:Float?
    
    init(with elementDict: [String:Any]){
        self.id = elementDict["id"] as? Int ?? nil
        self.recordUrl = elementDict["record_url"] as? String ?? ""
        self.name = elementDict["name"] as? String ?? ""
        self.number = elementDict["number"] as? Int ?? nil
        self.weight = elementDict["weight"] as? Float ?? nil
        self.symbol = elementDict["symbol"] as? String ?? ""
        self.meltingPoint = elementDict["melting_c"] as? Int ?? nil
        self.boilingPoint = elementDict["boiling_c"] as? Int ?? nil
        self.density = elementDict["density"] as? Float ?? nil
        self.crustPercent = elementDict["crust_percent"] as? Float ?? nil
        self.discoveryYear = elementDict["discovery_year"] as? String ?? ""
        self.group = elementDict["group"] as? Int ?? nil
        self.electrons = elementDict["electrons"] as? String ?? ""
        self.ionEnergy = elementDict["ion_energry"] as? Float ?? nil
    }
    
    static func makeElementObjs(from data:Data)-> [Element]{
        var elements: [Element] = []
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            
            if let elementArray = json as? [[String:Any]]{
                for elementDict in elementArray{
                    elements.append(Element(with: elementDict))
                }
            }
        }catch{
            print(error.localizedDescription)
        }
        return elements
    }

}
