public protocol ChatMessageProtocol {
    var message: String { get }
    var userID: String { get }
    var timestamp: Int { get }
}
