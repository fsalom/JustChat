public protocol DataSourceProtocol {
    func initialization()
    func getChats(with parameters: [String: Any]) async throws -> [ChatProtocol]
    func getChat(with id: String) async throws -> ChatProtocol
    func send(this message: ChatMessageProtocol) async throws
}
