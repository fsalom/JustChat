public class JustChatManager {
    var dataSource: DataSourceProtocol

    public init(with dataSource: DataSourceProtocol) {
        self.dataSource = dataSource
        self.initialization()
    }
}

extension JustChatManager: DataSourceProtocol {
    public func initialization() {
        self.dataSource.initialization()
    }

    public func getChats(with parameters: [String : Any]) async throws -> [ChatProtocol] {
        do {
            return try await self.dataSource.getChats(with: parameters)
        }catch{
            throw error
        }
    }

    public func getChat(with id: String) async throws -> ChatProtocol {
        do {
            return try await self.dataSource.getChat(with: id)
        }catch{
            throw error
        }
    }

    public func send(this message: ChatMessageProtocol) async throws {
        do {
            return try await self.dataSource.send(this: message)
        }catch{
            throw error
        }
    }
}
