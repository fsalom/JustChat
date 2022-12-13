//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 7/11/22.
//

import UIKit
import AlamofireImage

class ChatCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var chatImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!

    // MARK: - Properties

    // MARK: - Functions
    func display(chat: ChatProtocol) {
        chatImageView.layer.cornerRadius = chatImageView.bounds.height / 2
        if let url = URL(string: chat.photo) {
            chatImageView.af.setImage(withURL: url)
        }
        titleLabel.text = chat.name
    }
}
