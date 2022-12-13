import Foundation
public class JustChatManager {
    var dataSource: DataSourceProtocol

    public init(with dataSource: DataSourceProtocol) {
        self.dataSource = dataSource
        self.initialization()
    }
}

extension JustChatManager: DataSourceProtocol {
    public func initialization()  {
        self.dataSource.initialization()
    }

    public func getChats() async throws -> [ChatProtocol] {
        do {
            return try await self.dataSource.getChats()
        } catch {
            throw error
        }
    }

    public func getChat(with id: String, completionCurrentChat: ((Result<ChatProtocol, DataSourceError>) -> Void)?) {
        return self.dataSource.getChat(with: id, completionCurrentChat: completionCurrentChat)
    }

    public func send(this message: ChatMessageProtocol, for chatID: String) async throws {
        do {
            return try await self.dataSource.send(this: message, for: chatID)
        } catch {
            throw error
        }
    }

    public func didExitChat(id: String) {
        self.dataSource.didExitChat(id: id)
    }

    public func getUser() -> UserProtocol {
        return self.dataSource.getUser()
    }
}
