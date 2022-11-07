public class ChatMessage {
    var id: String
    private var text, userId: String
    var timestamp: Int

    init(id: String, text: String, userId: String, timestamp: Int) {
        self.id = id
        self.text = text
        self.userId = userId
        self.timestamp = timestamp
    }
}

extension ChatMessage: ChatMessageProtocol{
    public var message: String {
        return text
    }

    public var userID: String {
        return userId
    }
}
