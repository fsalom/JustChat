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
    let chat: ChatProtocol

    // MARK: - Init
    init(chat: ChatProtocol, manager: JustChatManager) {
        self.chat = chat
        self.manager = manager
    }
}
