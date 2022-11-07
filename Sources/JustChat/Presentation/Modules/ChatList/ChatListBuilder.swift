//
//  ChatListBuilder.swift
//  
//
//  Created by Pablo Ceacero on 7/11/22.
//

import UIKit

public class ChatListBuilder {
    static public func build(manager: JustChatManager) -> ChatListViewController {
        let viewController = UIViewController.getStoryboardVC(ChatListViewController.self)
        let router = ChatListRouter(viewController: viewController)
        let viewModel = ChatListViewModel(router: router, manager: manager)
        viewController.viewModel = viewModel
        return viewController
    }
}
