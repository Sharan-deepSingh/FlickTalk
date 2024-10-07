//
//  ChatViewController.swift
//  Bubbly
//
//  Created by Sharandeep Singh on 04/10/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

enum MessageType {
    
    case sender
    case receiver
}

class ChatViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    //MARK: - Properties
    let db = Firestore.firestore()
    var messages: [MessageModel] = []
    
    //MARK: - LifeCycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "🎈FlickTalk"
        navigationItem.hidesBackButton = true
        loadData()
    }
    
    //MARK: - IBActions
    @IBAction func LogoutButtonPressed(_ sender: UIBarButtonItem) {
        let indicator = showLoader()
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            showAlert(ofType: .externalError(error))
        }
        hideLoader(indicator: indicator)
    }
    
    @IBAction func messageSendButtonPressed(_ sender: UIButton) {
        if let message = messageTextField.text,
           let senderEmail = Auth.auth().currentUser?.email {
            messageTextField.text = ""
            
            /// Let's store data in database under collection named as "messages"
            db.collection("messages").addDocument(data: [
                    "sender": senderEmail,
                    "body": message,
                    "timeStamp": Date().timeIntervalSince1970
            ]) { error in
                if let e = error {
                    self.showAlert(ofType: .externalError(e))
                } else {
                    self.loadData()
                }
            }
        }
    }
    
    //MARK: - UI Configuration Methods
    private func scrollTableViewToBottom() {
        let numberOfRows = messages.count - 1
        
        if numberOfRows >= 0 {
            let indexPath = IndexPath(row: numberOfRows, section: 0)
            
            chatTableView.scrollToRow(
                at: indexPath,
                at: .bottom,
                animated: true
            )
        }
    }
    
    //MARK: - Data Updation Related Methods
    private func loadData() {
        db.collection("messages").order(by: "timeStamp").addSnapshotListener { querySnapshot, error in
            if let e = error {
                guard let _ = Auth.auth().currentUser else { return }
                
                self.showAlert(ofType: .externalError(e))
            } else {
                self.messages = []
                
                if let querySnapshot = querySnapshot {
                    let documents = querySnapshot.documents
                    
                    for document in documents {
                        let documentData = document.data()
                        
                        let messageModel = MessageModel(
                            sender: documentData["sender"] as? String,
                            body: documentData["body"] as? String,
                            timeStamp: documentData["timeStamp"] as? String
                        )
                        self.messages.append(messageModel)
                    }
                    
                    DispatchQueue.main.async {
                        self.chatTableView.reloadData()
                        self.scrollTableViewToBottom()
                    }
                } else {
                    self.showAlert(ofType: .messagesFetchingFailed)
                }
            }
        }
    }
}


//MARK: - TableView Handling
/// We will not handle UI part in this extension for Table View
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let messageUser = messages[indexPath.row].sender
        let loggedInUser = Auth.auth().currentUser?.email ?? ""
        let loggedInUserSameAsMessageUser = messageUser == loggedInUser
        
        if loggedInUserSameAsMessageUser {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SenderMessage",
                                                     for: indexPath) as! SenderMessageTableViewCell
            cell.message = messages[indexPath.row]
            cell.configureCell()
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverMessage",
                                                     for: indexPath) as! ReceiverMessageTableViewCell
            cell.message = messages[indexPath.row]
            cell.configureCell()
            return cell
        }
    }
}
