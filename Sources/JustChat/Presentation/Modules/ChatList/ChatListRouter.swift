//
//  ChatListRouter.swift
//  
//
//  Created by Pablo Ceacero on 7/11/22.
//

import UIKit

class ChatListRouter {
    // MARK: - Properties
    let viewController: ChatListViewController

    init(viewController: ChatListViewController) {
        self.viewController = viewController
    }

    func navigateToChat(_ chat: ChatProtocol) {
        let justChatVC = JustChatBuilder.build(chat: chat,manager: self.viewController.viewModel.manager)
        self.viewController.navigationController?.pushViewController(justChatVC, animated: true)
    }
}
