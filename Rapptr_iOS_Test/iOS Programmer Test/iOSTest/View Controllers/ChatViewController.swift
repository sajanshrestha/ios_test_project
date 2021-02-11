//
//  ChatViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit
import SVProgressHUD

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
    
    // MARK: - Initializerss
    init(model: ChatViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SVProgressHUD.dismiss()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Chat"
        configureTable()
        model.delegate = self
        
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
    
    private func updateUIwithLoadingStatus() {
        if model.isLoading {
            SVProgressHUD.show()
            chatTable.isHidden = true
        }
        else {
            SVProgressHUD.dismiss()
            chatTable.isHidden = false
        }
    }
      
    private func getImage(for url: URL) -> UIImage {
        var image = UIImage(named: "user")!
        do {
            let data = try Data(contentsOf: url)
            image = UIImage(data: data) ?? UIImage()
        }
        catch {
            print("error")
        }
        return image
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.messages.count
    }
}


extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier) as! ChatTableViewCell
        let message = model.messages[indexPath.row]
        cell.header.text = message.username
        cell.body.text = message.text
        cell.avatarImageView.image = getImage(for:  message.avatarURL)

//        cell.avatarImageView.image = getImage(for: message.avatarUrl)
//        cell.header.text = message.name
//        cell.body.text = message.message
        return cell
    }
}


extension ChatViewController: ChatMessageDelegate {
    func didSetMessages() {
        DispatchQueue.main.async { [self] in
            
            // this delay is just to simulate a little longer network call
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                updateUIwithLoadingStatus()
                self.chatTable.reloadData()
            }
        }
    }
}


