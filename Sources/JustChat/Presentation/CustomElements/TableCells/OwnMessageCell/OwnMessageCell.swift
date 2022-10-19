//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 18/10/22.
//

import UIKit

class OwnMessageCell: UITableViewCell {

    @IBOutlet weak private var messageContainerView: UIView!
    @IBOutlet weak private var messageLabel: UILabel!

    func display(with message: String) {
        messageContainerView.layer.cornerRadius = 10
        messageLabel.text = message
    }
}
