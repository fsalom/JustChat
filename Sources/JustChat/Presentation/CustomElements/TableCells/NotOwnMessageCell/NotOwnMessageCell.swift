//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 18/10/22.
//

import UIKit

class NotOwnMessageCell: UITableViewCell {

    @IBOutlet weak private var messageContainerView: UIView!
    @IBOutlet weak private var messageLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!

    func display(with message: ChatMessageProtocol) {
        messageContainerView.layer.cornerRadius = 10
        messageLabel.text = message.message
        hourLabel.text = Date(timeIntervalSince1970: TimeInterval(message.timestamp)).toString(withFormat: "HH:mm")
    }
}
