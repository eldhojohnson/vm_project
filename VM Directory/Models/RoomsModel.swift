//
//  RoomsModel.swift
//  VM Directory
//
//  Created by Eldho on 11/07/22.
//

import ObjectMapper
import Foundation

class RoomsModel: Mappable {
    
    var createdAt: String?
    var isOccupied: Bool = false
    var maxOccupancy: Int?
    var id: String?
    
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        
        createdAt <- map["createdAt"]
        isOccupied <- map["isOccupied"]
        maxOccupancy <- map["maxOccupancy"]
        id <- map["id"]
        
    }
  
}
