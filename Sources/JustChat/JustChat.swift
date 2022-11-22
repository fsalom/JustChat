import Foundation
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

    public func getUserID() throws -> String {
        do {
            return try self.dataSource.getUserID()
        } catch {
            throw error
        }
    }

    public func getChats(with parameters: [String : Any]) async throws -> [ChatProtocol] {
        do {
            return try await self.dataSource.getChats(with: parameters)
        } catch {
            throw error
        }
    }

    public func getChat(with id: String, completionCurrentChat: ((ChatProtocol) -> Void)? = nil) throws {
        do {
            return try self.dataSource.getChat(with: id, completionCurrentChat: completionCurrentChat)
        } catch {
            throw error
        }
    }

    public func send(this message: ChatMessageProtocol, for chatID: String) async throws {
        do {
            return try await self.dataSource.send(this: message, for: chatID)
        } catch {
            throw error
        }
    }

    public func receive(this message: ChatMessageProtocol) async throws {
        do {
            return try await self.dataSource.receive(this: message)
        }catch{
            throw error
        }
    }
}
