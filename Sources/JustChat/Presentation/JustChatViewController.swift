//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 18/10/22.
//

import UIKit

public class JustChatViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    var toolBar: ChatToolBar?

    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        configure(tableView)
    }

    // MARK: - ChatToolBar
    public override var inputAccessoryView: UIView? {
        get {
            if toolBar == nil {
                toolBar = Bundle.module.loadNibNamed("ChatToolBar", owner: self, options: nil)?.first as? ChatToolBar
                toolBar?.setup()
            }

            return toolBar
        }
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

        tableView.contentInset.bottom = inputAccessoryView?.frame.height ?? 70

        tableView.register(UINib(nibName: "OwnMessageCell",
                                 bundle: .module),
                           forCellReuseIdentifier: "OwnMessageCell")

        tableView.register(UINib(nibName: "NotOwnMessageCell",
                                 bundle: .module),
                           forCellReuseIdentifier: "NotOwnMessageCell")
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OwnMessageCell",
                                                     for: indexPath) as! OwnMessageCell

            cell.display(with: "Message number \(indexPath.row)")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotOwnMessageCell",
                                                     for: indexPath) as! NotOwnMessageCell

            cell.display(with: "Message number \(indexPath.row)")
            return cell
        }
    }
}
