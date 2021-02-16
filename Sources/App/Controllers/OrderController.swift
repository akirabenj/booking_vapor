//
//  File.swift
//  
//
//  Created by temir on 08.12.2020.
//

import Foundation
import Fluent
import Vapor

struct OrderController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let orders = routes.grouped("api", "orders")
        orders.get("validate", use: validateOrder)
        orders.get("ordersByDate", use: getOrdersByDate)
        orders.post("create", use: create)
        orders.post("check", use: checkPlace)
    }
    
    func validateOrder(req: Request) throws -> EventLoopFuture<Int> {
        guard let uuid = UUID(try req.content.decode(String.self)) else { throw Abort(.badRequest) }
        return Order.query(on: req.db)
            .filter(\.$id == uuid)
            .first()
            .map { order in
                return (order != nil) ? 1 : 0
            }
    }
    
    func getOrdersByDate(req: Request) throws -> EventLoopFuture<[String]> {
        guard let date = (try req.content.decode(String.self)).toDate() else { throw Abort(.badRequest) }
        return Order.query(on: req.db)
            .all()
            .map { orders in
                let filteredOrders = orders.filter({ $0.bookingDate == date })
                return filteredOrders.map({ $0.$place.id.uuidString })
            }
    }
    
    func create(req: Request) throws -> EventLoopFuture<String> {
        let newOrder = try req.content.decode(Order.self)
        return newOrder.save(on: req.db).map {
            guard let stringID = newOrder.id?.uuidString else { return "" }
            return stringID
        }
    }
    
    func checkPlace(req: Request) throws -> EventLoopFuture<Int> {
        let order = try req.content.decode(Order.self)
        return Order.query(on: req.db)
            .all()
            .map { orders in
                let result = orders.contains(where: { $0.$place.id == order.$place.id &&
                                                    $0.bookingDate == order.bookingDate }) ? 1 : 0
                return result
            }
    }
}
