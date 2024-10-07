//
//  SenderMessageTableViewCell.swift
//  FlickTalk
//
//  Created by Sharandeep Singh on 05/10/24.
//

import UIKit

class SenderMessageTableViewCell: UITableViewCell {

    //MARK: - IBBoutlets
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var senderProfileImage: UIImageView!
    
    //MARK: - Properties
    var message: MessageModel?
    
    //MARK: - UIConfiguration Methods
    func configureCell() {
        senderProfileImage.layer.cornerRadius = 20
        messageView.layer.cornerRadius = CommonMethods.getCornerRadius(
            forHeight: messageView.frame.height
        )
        loadDataOnCell()
    }
    
    private func loadDataOnCell() {
        messageLabel.text = message?.body
    }
}
