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

        setupBindings()
        setupNavigation()
        configure(inputMessageView)
        configure(tableView)
        goToBottom()
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

    // MARK: - Functions
    func setupNavigation() {
        self.navigationItem.title = self.viewModel.chat.name
        self.navigationController?.navigationBar.barTintColor = .white
    }

    func setupBindings() {
        viewModel.chatDidChange = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.tableView.reloadData()
                self.goToBottom()
            }
        }
    }

    func goToBottom() {
        if (self.viewModel.chat.messages.count - 1) >= 0 {
            self.tableView.scrollToRow(at: IndexPath(row: self.viewModel.chat.messages.count - 1, section: 0),
                                       at: .bottom,
                                       animated: false)
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension JustChatViewController: UITableViewDelegate, UITableViewDataSource {
    func configure(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.contentInset.bottom = 55
        tableView.verticalScrollIndicatorInsets.bottom = 55

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

                cell.display(with: message)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NotOwnMessageCell",
                                                         for: indexPath) as! NotOwnMessageCell

                cell.display(with: message)
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
        viewModel.send(message: message)
    }
}
