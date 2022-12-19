//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 19/12/22.
//

import UIKit

class MemberCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    // MARK: - Functions
    func display(user: UserProtocol) {
        nameLabel.text = user.name
    }
}
