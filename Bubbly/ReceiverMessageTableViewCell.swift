//
//  ReceiverMessageTableViewCell.swift
//  FlickTalk
//
//  Created by Sharandeep Singh on 06/10/24.
//

import UIKit

class ReceiverMessageTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var receiverProfileImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    
    //MARK: - Messages
    var message: MessageModel?
    
    //MARK: - UI Configuration Methods
    func configureCell() {
        receiverProfileImage.layer.cornerRadius = 20
        messageView.layer.cornerRadius = CommonMethods.getCornerRadius(
            forHeight: messageView.frame.height
        )
        loadDataOnCell()
    }
    
    private func loadDataOnCell() {
        messageLabel.text = message?.body
    }
}
