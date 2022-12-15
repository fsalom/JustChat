class Chat: ChatProtocol {
    var id,name, photo: String
    var messages: [[ChatMessageProtocol]]
    var users: [String]
    var type: ChatType

    init(id: String, name: String, photo: String, users: [String], messages: [[ChatMessageProtocol]], type: ChatType) {
        self.id = id
        self.name = name
        self.photo = photo
        self.users = users
        self.messages = messages
        self.type = type
    }
}
