//
//  ChatListViewModel.swift
//  
//
//  Created by Pablo Ceacero on 7/11/22.
//

import Foundation

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
    }

    func getChats() {
        Task {
            do {

                let chats = try await manager.getChats(with: [:])
                self.chats = chats
            } catch {
                if let firebaseError = error as? FirebaseDataSource.FirebaseError {
                    print(firebaseError)
                } else {
                    print(error)
                }
            }
        }
    }

    func didSelectChatAt(_ index: Int) {
        router.navigateToChat(chats[index])
    }
}
