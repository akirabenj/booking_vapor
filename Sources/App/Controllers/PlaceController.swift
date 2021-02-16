//
//  File.swift
//  
//
//  Created by temir on 07.12.2020.
//

import Foundation
import Fluent
import Vapor

struct PlaceController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let places = routes.grouped("api", "places")
        places.get(use: getAll) 
        places.post(use: create)
    }
    
    func getAll(req: Request) throws -> EventLoopFuture<[PlaceDTO]> {
        return Place.query(on: req.db).all().flatMapThrowing { places in
            places.map { place in
                PlaceDTO(id: place.id,
                         name: place.name)
            }
        }
    }
    
    func create(req: Request) throws -> EventLoopFuture<Place> {
        let place = try req.content.decode(Place.self)
        return place.save(on: req.db).map { place }
    }
}
