//
//  ChatListViewModel.swift
//  
//
//  Created by Pablo Ceacero on 7/11/22.
//

import UIKit

class ChatListViewModel {
    // MARK: - Properties
    let router: ChatListRouter
    let manager: JustChatManager
    var chats = [ChatProtocol]() {
        didSet { chatsDidChange?() }
    }
    var chatsDidChange: (() -> Void)?

    // MARK: - Init
    init(router: ChatListRouter, manager: JustChatManager) {
        self.manager = manager
        self.router = router
        self.getChats()
    }

    func getChats() {
        Task {
            do {
                let chats = try await manager.getChats()
                self.chats = chats
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

    func didSelectChatAt(_ index: Int, chatImage: UIImage) {
        router.navigateToChat(chats[index], chatImage: chatImage)
    }
}
