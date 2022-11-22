public protocol DataSourceProtocol {
    func initialization()
    func getChats(with parameters: [String: Any]) async throws -> [ChatProtocol]
    func getChat(with id: String, completionCurrentChat: ((ChatProtocol) -> Void)?) throws
    func send(this message: ChatMessageProtocol, for chatID: String) async throws
    func receive(this message: ChatMessageProtocol) async throws
    func getUserID() throws -> String
}
