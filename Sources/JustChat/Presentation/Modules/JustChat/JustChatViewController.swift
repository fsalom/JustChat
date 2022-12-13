//
//  File.swift
//  
//
//  Created by Pablo Ceacero on 18/10/22.
//

import UIKit
import Alamofire

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

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        viewModel.viewDidDisappear()
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
        // NavigationBar appearance
        let newNavBarAppearance = UINavigationBarAppearance()
        newNavBarAppearance.configureWithOpaqueBackground()
        newNavBarAppearance.backgroundColor = .systemBackground
        navigationController!.navigationBar.scrollEdgeAppearance = newNavBarAppearance
        navigationController!.navigationBar.compactAppearance = newNavBarAppearance
        navigationController!.navigationBar.standardAppearance = newNavBarAppearance
        navigationItem.leftItemsSupplementBackButton = true

        // Back button
        let imgBack = UIImage(named: "ic_back")
        navigationController?.navigationBar.backIndicatorImage = imgBack
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBack
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)

        // Profile ImageView
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 17.5
        imageView.clipsToBounds = true
        imageView.image = viewModel.chatImage
        imageView.contentMode = .scaleAspectFill
        imageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0, constant: 0).isActive = true

        // Name Label
        let textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        textLabel.text  = viewModel.chat.name
        textLabel.textAlignment = .center
        textLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true

        //Stack View
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 5

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(UIView())

        self.navigationItem.titleView = stackView
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

    func goToBottom(animated: Bool = false) {
        if (self.viewModel.chat.messages.count - 1) >= 0 {
            self.tableView.scrollToRow(at: IndexPath(row: self.viewModel.chat.messages.count - 1,
                                                     section: 0),
                                       at: .bottom,
                                       animated: animated)
        }
    }

    // MARK: - Observers
    @objc func willShow(notification: Notification) {
        print("Will Show")
        let height = notification.getKeyBoardHeight
        if height > 350 {
            // Keyboard is shown
            tableView.contentInset.bottom = height
            tableView.verticalScrollIndicatorInsets.bottom = height
            goToBottom(animated: true)
        }
    }

    @objc func willHide(notification: Notification) {
        print("Will Hide")
        let height = notification.getKeyBoardHeight
        if height > 350 {
            // Keyboard is shown
            tableView.contentInset.bottom = height
            tableView.verticalScrollIndicatorInsets.bottom = height
            goToBottom(animated: true)
        } else {
            tableView.contentInset.bottom = 55
            tableView.verticalScrollIndicatorInsets.bottom = 55
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
        let message = viewModel.chat.messages[indexPath.row]
        let userID = viewModel.user.id
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
