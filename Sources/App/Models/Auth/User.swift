import Fluent
import Vapor

final class User: Model {

    static let schema = "users"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "username")
    var username: String

    @Field(key: "pass_hash")
    var passHash: String

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    init() {}

    init(id: UUID? = nil, username: String, passHash: String) {
        self.id = id
        self.username = username
        self.passHash = passHash
    }
}

extension User: Authenticatable {
    static func create(from userSignup: UserSignup) throws -> User {
        return User(username: userSignup.username, passHash: try Bcrypt.hash(userSignup.password))
    }

    func createToken(source: SessionSource) throws -> Token {
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        let expiryDate = calendar.date(byAdding: .year, value: 1, to: currentDate)
        let token = [UInt8].random(count: 16).base64
        
        return try Token(userId: requireID(), token: token, source: source, expiresAt: expiryDate)
    }
}