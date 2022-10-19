//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 19/10/22.
//

import UIKit

class ChatInputView: UIView {
    // MARK: - Properties

    // MARK: - IBOutlets
    @IBOutlet weak var textView: UITextView!

    // MARK: - Properties

    // MARK: - Life cycle
    override var intrinsicContentSize: CGSize {
        return CGSize(width: self.bounds.width, height: 80)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        configure(textView)
    }

    // MARK: UITextFieldDelegate
    func configure(_ textView: UITextView) {
        textView.layer.cornerRadius = 10
    }
}
