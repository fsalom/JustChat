//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 19/12/22.
//

import UIKit

public class ChatMembersViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel: ChatMembersViewModel!

    // MARK: - Functions
}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension ChatMembersViewController: UITableViewDelegate, UITableViewDataSource {
    func configure(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "MemberCell",
                                 bundle: Bundle.module),
                           forCellReuseIdentifier: "MemberCell")
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell") as! MemberCell
        cell.display(user: <#T##UserProtocol#>)
        return cell
    }
}
