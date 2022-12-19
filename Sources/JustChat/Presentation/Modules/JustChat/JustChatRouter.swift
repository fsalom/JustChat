//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 19/12/22.
//

import Foundation

public class JustChatRouter {
    let viewController: JustChatViewController

    init(viewController: JustChatViewController) {
        self.viewController = viewController
    }

    func presentMembersList() {
        let vc = ChatMembersBuilder.build()
        self.viewController.present(vc, animated: true)
    }
}
