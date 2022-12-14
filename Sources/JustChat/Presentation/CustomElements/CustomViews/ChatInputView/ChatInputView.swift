//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 19/10/22.
//

import UIKit

protocol ChatInputViewDelegate: AnyObject {
    func didPressSendButton(with message: String)
}

class ChatInputView: UIView {
    // MARK: - Properties

    // MARK: - IBOutlets
    @IBOutlet weak var textView: UITextView!

    // MARK: - Properties
    weak var delegate: ChatInputViewDelegate!

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

    // MARK: - IBActions
    @IBAction func sendButtonPressed(_ sender: Any) {
        if textView.text.isEmpty { return }
        delegate?.didPressSendButton(with: textView.text)
        textView.text = ""
    }
}
