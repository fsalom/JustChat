public protocol ChatProtocol {
    var id: String { get }
    var name: String { get }
    var lastMessage: String { get }
    var otherUserId: String { get }
    var otherUserImage: String { get }
    var messages: [ChatMessageProtocol] { get }
}
