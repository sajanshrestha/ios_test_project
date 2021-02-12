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
     *
     * 􀓣 ======================================================================================== 􀓣
     * This view controller has a property called "model" which acts as a view model. This view model is responsible for providing all the "messages" to the table view. To do so, the view model makes a network
     * call during initialization. If successful, it will populate 'messages' property in it. Once the 'messages' property is set, the model asks its delegate to carry out necessary action. In this case, the delegate is
     * this view controller. And when the "messages" are populated, the view controller reloads its table view and thus displaying the messages.
     * 􀓣 ======================================================================================== 􀓣

     **/
    
    
    // MARK: - Properties
    var chatRoom: ChatRoom
    
    // MARK: - Outlets
    @IBOutlet weak var chatTable: UITableView!
    
    // MARK: - Initializerss
    init(model: ChatRoom) {
        self.chatRoom = model
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
        chatRoom.delegate = self
        
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
        if chatRoom.isLoadingMessages {
            SVProgressHUD.show()
            chatTable.isHidden = true
        }
        else {
            SVProgressHUD.dismiss()
            chatTable.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatRoom.messages.count
    }
}


extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier) as! ChatTableViewCell
        let message = chatRoom.messages[indexPath.row]
        cell.header.text = message.username
        cell.body.text = message.text
        
        // sets placeholder image (if there is delay or any error while fetching, cell will still have a default image)
        cell.avatarImageView.image = UIImage(named: "user")!
        
        setAvatarImage(for: message, in: cell)
        
        return cell
    }
    
    // if successful, places the fetched imaged on cell
    private func setAvatarImage(for message: Message, in cell: ChatTableViewCell) {
        if let image = chatRoom.cachedAvatarImage(for: message.avatarURL.absoluteString) {
            cell.avatarImageView.image = image
        }
        else {
            downloadAvatarImage(of: message, for: cell)
        }
    }
    
    private func downloadAvatarImage(of message: Message, for cell: ChatTableViewCell) {
        ImageClient.image(for: message.avatarURL) { image in
            DispatchQueue.main.async {
                cell.avatarImageView.image = image
            }
            if let image = image {
                self.chatRoom.cacheAvatarImage(image, key: message.avatarURL.absoluteString)
            }
        }
    }
}


extension ChatViewController: ChatMessageDelegate {
    func didSetMessages() {
        DispatchQueue.main.async {
            self.updateUIwithLoadingStatus()
            self.chatTable.reloadData()
        }
    }
}
