//
//  File.swift
//  
//
//  Created by temir on 07.12.2020.
//

import Foundation
import Fluent
import Vapor

extension FieldKey {
    static var name: Self { "name" }
    static var personsCount: Self { "persons_count" }
    static var bookingDate: Self { "booking_date" }
}

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"
        return formatter.date(from: self)
    }
}
