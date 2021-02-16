import Fluent

struct CreatePlace: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("Places")
            .id()
            .field(.name, .string, .required)
            .field("created_at", .date)
            .field("updated_at", .date)
            .field("deleted_at", .date)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("Places").delete()
    }
}

struct CreateOrder: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("Orders")
            .id()
            .field(.personsCount, .int, .required)
            .field(.bookingDate, .date, .required)
            .field("place_id", .uuid, .required, .references("Places", .id))
            .field("created_at", .date)
            .field("updated_at", .date)
            .field("deleted_at", .date)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("Orders").delete()
    }
}
