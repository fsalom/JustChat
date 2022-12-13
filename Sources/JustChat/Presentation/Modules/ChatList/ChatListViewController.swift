//
//  ChatListViewController.swift
//  
//
//  Created by Pablo Ceacero on 7/11/22.
//

import UIKit

public class ChatListViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel: ChatListViewModel!

    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        setupBindings()
        configure(tableView)
    }

    // MARK: - Functions
    func setupBindings() {
        viewModel.chatsDidChange = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.tableView.reloadData()
            }
        }
    }

    func setupNavigation() {
        navigationItem.title = "Chats"
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
    func configure(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "ChatCell",
                                 bundle: .module), forCellReuseIdentifier: "ChatCell")
    }

    // DataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chats.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        cell.display(chat: viewModel.chats[indexPath.row])
        return cell
    }

    // Delegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ChatCell
        let chatImage = cell.chatImageView.image ?? UIImage()
        viewModel.didSelectChatAt(indexPath.row, chatImage: chatImage)
    }
}
