//
//  File.swift
//  
//
//  Created by temir on 07.12.2020.
//

import Foundation
import Fluent
import Vapor

final class Order: Model, Content {
    static let schema: String = "Orders"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: .personsCount)
    var personsCount: Int
    
    @Field(key: .bookingDate)
    var bookingDate: Date
    
    @Parent(key: "place_id")
    var place: Place
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil,
         personsCount: Int,
         bookingDate: Date,
         place: Place) throws {
        self.id = id
        self.personsCount = personsCount
        self.bookingDate = bookingDate
        self.$place.id = try place.requireID()
    }
}
