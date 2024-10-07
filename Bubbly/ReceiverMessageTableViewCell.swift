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
    
    //MARK: - UI Configuration Methods
    func configureCell() {
        receiverProfileImage.layer.cornerRadius = 20
        messageView.layer.cornerRadius = (messageView.frame.size.height / 12)
    }
}
