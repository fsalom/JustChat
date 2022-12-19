//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 27/10/22.
//

import UIKit

public class JustChatBuilder {
    static public func build(chat: ChatProtocol, chatImage: UIImage) -> JustChatViewController {
        let viewController = UIViewController.getStoryboardVC(JustChatViewController.self)
        let router = JustChatRouter(viewController: viewController)
        let viewModel = JustChatViewModel(router: router, chat: chat, chatImage: chatImage)
        viewController.viewModel = viewModel
        return viewController
    }
}
