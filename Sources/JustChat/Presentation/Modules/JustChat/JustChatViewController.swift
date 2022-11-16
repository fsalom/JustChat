//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 18/10/22.
//

import UIKit

public class JustChatViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var inputMessageView: ChatInputView!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel: JustChatViewModel!
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        configure(inputMessageView)
        configure(tableView)
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)


        let point = CGPoint(x: 0, y: self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.frame.height + inputAccessoryView!.frame.height)
        tableView.setContentOffset(point,
                                   animated: false)
    }

    // MARK: - ChatToolBar
    public override var inputAccessoryView: UIView? {
        return inputMessageView
    }

    public override var canBecomeFirstResponder: Bool {
        return true
    }

    public override var canResignFirstResponder: Bool {
        return true
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension JustChatViewController: UITableViewDelegate, UITableViewDataSource {
    func configure(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.contentInset.bottom = inputAccessoryView!.frame.height
        tableView.verticalScrollIndicatorInsets.bottom = inputAccessoryView!.frame.height

        tableView.register(UINib(nibName: "OwnMessageCell",
                                 bundle: .module),
                           forCellReuseIdentifier: "OwnMessageCell")

        tableView.register(UINib(nibName: "NotOwnMessageCell",
                                 bundle: .module),
                           forCellReuseIdentifier: "NotOwnMessageCell")
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chat.messages.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        do {
            let message = viewModel.chat.messages[indexPath.row]
            let userID = try viewModel.manager.getUserID()
            if message.userID == userID {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OwnMessageCell",
                                                         for: indexPath) as! OwnMessageCell

                cell.display(with: message.message)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NotOwnMessageCell",
                                                         for: indexPath) as! NotOwnMessageCell

                cell.display(with: message.message)
                return cell
            }
        } catch {
            if let firebaseError = error as? FirebaseDataSource.FirebaseError {
                print(firebaseError)
            } else {
                print(error)
            }
        }
        return UITableViewCell()
    }
}


extension JustChatViewController: ChatInputViewDelegate {
    func configure(_ inputAccessoryView: ChatInputView) {
        inputAccessoryView.delegate = self
    }

    func didPressSendButton(with message: String) {
    }
}
