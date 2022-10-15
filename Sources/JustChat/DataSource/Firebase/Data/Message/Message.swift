class ChatMessage {
    var id: String
    var text: String
    var image: String

    init(id: String, text: String, image: String) {
        self.id = id
        self.text = text
        self.image = image
    }
}

extension ChatMessage: ChatMessageProtocol{
    var message: String {
        return text
    }

    var imageURL: String {
        return image
    }

}
