public protocol DataSourceProtocol {
    func initialization()
    func getChats() async throws -> [ChatProtocol]
    func getChat(with id: String, completionCurrentChat: ((Result<ChatProtocol, DataSourceError>) -> Void)?)
    func send(this message: ChatMessageProtocol, for chatID: String) async throws
    func didExitChat(id: String)
    func getUser() -> UserProtocol
}

public enum DataSourceError: Error {
    case userNotFound
    case noData
    case parseError
    case unknownError

}
