import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    let collections: [RouteCollection] = [PlaceController(), OrderController()]
    try collections.forEach { (collection) in
        try app.register(collection: collection)
    }
}


