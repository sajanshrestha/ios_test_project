//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Setup cell to match mockup
     *
     * 2) Include user's avatar image
     *
     ** =========================================================================================
     *
     *
     * 􀓣 ======================================================================================== 􀓣
     * Used programmatic approach to create UI elements.
     * 􀓣 ======================================================================================== 􀓣
     **/
    
    static let identifier = "ChatTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Views
    lazy var avatarImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = imageViewWidth / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var header: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: userNameFontSize, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var bubbleView: UIView = {
        var view = UIView()
        view.layer.borderWidth = 1.0
        view.layer.borderColor = #colorLiteral(red: 0.9371829629, green: 0.9372954369, blue: 0.9371448159, alpha: 1).cgColor
        view.layer.cornerRadius = 8.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var body: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: messageFontSize, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Constants
    private let messageFontSize: CGFloat = 15.0
    private let userNameFontSize: CGFloat = 13.0
    private let imageViewWidth: CGFloat = 50.0
    private let messageTextInset: CGFloat = 8.0
}


extension ChatTableViewCell {
    
    private func addSubviews() {
        addAvatarImageView()
        addHeader()
        addBubbleView()
        addBody()
    }
    
    private func addAvatarImageView() {
        self.addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: imageViewWidth),
            avatarImageView.heightAnchor.constraint(equalToConstant: imageViewWidth),
        ])
    }
    
    private func addHeader() {
        self.addSubview(header)
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 7),
            header.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
        ])
    }
    
    private func addBubbleView() {
        self.addSubview(bubbleView)
        NSLayoutConstraint.activate([
            bubbleView.leadingAnchor.constraint(equalTo: header.leadingAnchor),
            bubbleView.topAnchor.constraint(equalTo: self.header.bottomAnchor, constant: 4),
            bubbleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -36),
            bubbleView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24)
        ])
    }
    
    private func addBody() {
        bubbleView.addSubview(body)
        NSLayoutConstraint.activate([
            body.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: messageTextInset),
            body.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -messageTextInset),
            body.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: messageTextInset),
            body.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -messageTextInset)
        ])
    }
}
