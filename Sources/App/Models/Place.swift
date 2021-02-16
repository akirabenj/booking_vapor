//
//  File.swift
//  
//
//  Created by temir on 07.12.2020.
//

import Foundation
import Fluent
import Vapor

final class Place: Model, Content {
    
    static let schema = "Places"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: .name)
    var name: String
    
    @Children(for: \.$place)
    var orders: [Order]
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() {}
    
    init(id: UUID? = nil,
         name: String,
         createdAt: Date? = nil,
         updatedAt: Date? = nil,
         deletedAt: Date? = nil) {
        self.name = name
    }
}

struct PlaceDTO: Content {
    var id: UUID?
    var name: String
}
