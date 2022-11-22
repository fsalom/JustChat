class Chat: ChatProtocol {
    var id,name, otherUserId, otherUserImage: String
    var messages: [ChatMessageProtocol]
    var lastMessage: String {
        return messages.last?.message ?? ""
    }

    init(id: String, name: String, otherUserId: String, otherUserImage: String, messages: [ChatMessageProtocol]) {
        self.id = id
        self.name = name
        self.otherUserId = otherUserId
        self.otherUserImage = otherUserImage
        self.messages = messages
    }
}
