//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 27/10/22.
//

import UIKit

public class JustChatBuilder {
    static public func build(chat: ChatProtocol, manager: JustChatManager) -> JustChatViewController {
        let viewController = UIViewController.getStoryboardVC(JustChatViewController.self)
        let viewModel = JustChatViewModel(chat: chat, manager: manager)
        viewController.viewModel = viewModel
        return viewController
    }
}
