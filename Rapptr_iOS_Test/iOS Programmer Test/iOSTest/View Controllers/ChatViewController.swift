//
//  ChatViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Using the following endpoint, fetch chat data
     *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
     *
     * 3) Parse the chat data using 'Message' model
     *
     **/
    
    // MARK: - Properties
    var model: ChatViewModel
    
    // MARK: - Outlets
    @IBOutlet weak var chatTable: UITableView!
    
    // MARK: - Initializers
    init(model: ChatViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Chat"
        configureTable()
        model.delegate = self
        
        addLoadingSpinner()
        updateUIwithLoadingStatus()
    }
    
    private func configureTable() {
        chatTable.delegate = self
        chatTable.dataSource = self
        chatTable.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.identifier)
        chatTable.separatorStyle = .none
        chatTable.rowHeight = UITableView.automaticDimension
        chatTable.estimatedRowHeight = 600
        chatTable.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        chatTable.allowsSelection = false
    }
    
    private func addLoadingSpinner() {
        view.addSubview(loadingSpinner)
        NSLayoutConstraint.activate([
            loadingSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingSpinner.heightAnchor.constraint(equalToConstant: 60),
            loadingSpinner.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func updateUIwithLoadingStatus() {
        if model.isLoading {
            loadingSpinner.startAnimating()
            chatTable.isHidden = true
        }
        else {
            loadingSpinner.stopAnimating()
            chatTable.isHidden = false
        }
    }
      
    private func getImage(for url: String) -> UIImage {
        var image = UIImage(named: "user")!
        do {
            if let url = URL(string: url) {
                let data = try Data(contentsOf: url)
                image = UIImage(data: data) ?? UIImage()
            }
        }
        catch {
            print("error")
        }
        return image
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.messages.count
    }
    
    // MARK: - Views
    var loadingSpinner: UIActivityIndicatorView = {
        var view = UIActivityIndicatorView()
        if #available(iOS 13.0, *) { view.style = .large }
        else { view.style = .gray }
        view.color = #colorLiteral(red: 0.2616125047, green: 0.4031680822, blue: 0.4401500523, alpha: 1)
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}


extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier) as! ChatTableViewCell
        let message = model.messages[indexPath.row]
        cell.avatarImageView.image = getImage(for: message.avatarUrl)
        cell.header.text = message.name
        cell.body.text = message.message
        return cell
    }
}


extension ChatViewController: ChatMessageDelegate {
    func didSetMessages() {
        DispatchQueue.main.async { [self] in
            updateUIwithLoadingStatus()
            self.chatTable.reloadData()
        }
    }
}
