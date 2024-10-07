//
//  ChatViewController.swift
//  Bubbly
//
//  Created by Sharandeep Singh on 04/10/24.
//

import UIKit
import FirebaseAuth

enum MessageType {
    
    case sender
    case receiver
}

class ChatViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    //MARK: - LifeCycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: - IBActions
    @IBAction func LogoutButtonPressed(_ sender: UIBarButtonItem) {
        let indicator = showLoader()
        do {
            try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        } catch {
            print("Logout error reason: ", error.localizedDescription)
        }
        hideLoader(indicator: indicator)
    }
    
    @IBAction func messageSendButtonPressed(_ sender: UIButton) {
    }    
}


//MARK: - TableView Handling
/// We will not handle UI part in this extension for Table View
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SenderMessage",
                                                     for: indexPath) as! SenderMessageTableViewCell
            cell.configureCell()
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverMessage",
                                                     for: indexPath) as! ReceiverMessageTableViewCell
            cell.configureCell()
            return cell
        }
    }
}
