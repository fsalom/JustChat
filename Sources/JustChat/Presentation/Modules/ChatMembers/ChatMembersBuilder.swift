//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 19/12/22.
//

import UIKit

public class ChatMembersBuilder {
    static public func build() -> ChatMembersViewController {
        let viewController = UIViewController.getStoryboardVC(ChatMembersViewController.self)
        let viewModel = ChatMembersViewModel()
        viewController.viewModel = viewModel
        return viewController
    }
}
