//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 27/10/22.
//

import UIKit

class JustChatViewModel {
    // MARK: - Properties
    let router: JustChatRouter
    var chatImage: UIImage
    var chat: ChatProtocol {
        didSet { chatDidChange?() }
    }
    var chatDidChange: (() -> Void)?

    var user: UserProtocol!

    // MARK: - Init
    init(router: JustChatRouter, chat: ChatProtocol, chatImage: UIImage) {
        self.router = router
        self.chat = chat
        self.chatImage = chatImage
        Task {
            await self.getUser()
            await self.getChat()
        }
    }

    func viewDidDisappear() {
        Container.shared.manager.didExitChat(id: chat.id)
    }

    func getUser() async {
        self.user = Container.shared.manager.getUser()
    }

    func getChat() async {
        Container.shared.manager.getChat(with: chat.id) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let chat): self.chat = chat
            case .failure(let dataSourceError): print(dataSourceError)
            }
        }
    }

    func send(message: String) {
        Task {
            do {
                let chatMessage = ChatMessage(id: UUID().uuidString,
                                              text: message,
                                              userId: user.id,
                                              timestamp: Int(Date().timeIntervalSince1970))
                try await Container.shared.manager.send(this: chatMessage,
                                                                 for: chat.id)
            } catch {
                // TODO
                if let dataSourceError = error as? DataSourceError {
                    print(dataSourceError)
                } else {
                    print(error)
                }
            }
        }
    }

    func goToChatMembers() {
        router.presentMembersList()
    }
}
