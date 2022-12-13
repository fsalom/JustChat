public protocol ChatProtocol {
    var id: String { get }
    var name: String { get }
    var photo: String { get }
    var users: [String] { get }
    var type: ChatType { get }
    var messages: [ChatMessageProtocol] { get }
}

public enum ChatType: String {
    case group
    case person
}
