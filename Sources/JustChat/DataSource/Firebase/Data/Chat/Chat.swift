class Chat {
    var id,name, lastMessage, otherUserId, otherUserImage: String
    var messages: [ChatMessageProtocol]

    init(id: String, name: String, lastMessage: String, otherUserId: String, otherUserImage: String, messages: [ChatMessage]) {
        self.id = id
        self.name = name
        self.lastMessage = lastMessage
        self.otherUserId = otherUserId
        self.otherUserImage = otherUserImage
        self.messages = messages
    }
}

extension Chat: ChatProtocol{
    var idChat: String {
        return self.id
    }

    var nameChat: String {
        return self.name
    }
}
