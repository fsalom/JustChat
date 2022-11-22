//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 27/10/22.
//

import Foundation

class JustChatViewModel {
    // MARK: - Properties
    let manager: JustChatManager
    var chat: ChatProtocol {
        didSet { chatDidChange?() }
    }
    var chatDidChange: (() -> Void)?

    // MARK: - Init
    init(chat: ChatProtocol, manager: JustChatManager) {
        self.chat = chat
        self.manager = manager
        self.getChat()
    }

    func getChat() {
        do {
            try manager.getChat(with: chat.id, completionCurrentChat: { [weak self] chat in
                guard let self else { return }
                self.chat = chat
            })
        } catch {}

    }

    func send(message: String) {
        Task {
            do {
                let chatMessage = ChatMessage(id: UUID().uuidString, text: message, userId: try manager.getUserID(), timestamp: Int(Date().timeIntervalSince1970))
                try await manager.send(this: chatMessage, for: chat.id)

            } catch {

            }
        }
    }
}
