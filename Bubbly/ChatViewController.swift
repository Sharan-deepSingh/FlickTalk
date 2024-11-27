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
    @IBOutlet weak var bottomMessageSenderView: UIView!
    @IBOutlet weak var chatLoader: UIActivityIndicatorView!
    
    //MARK: - Properties
    let db = Firestore.firestore()
    var messages: [MessageModel] = []
    var fetchAfterDocument: QueryDocumentSnapshot?
    var isInitialLoad = true
    var lastApperedIndex: Int?
    var isLoading = false
    
    //MARK: - LifeCycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
        addMessageListener()
        loadInitialMessages()
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
                }
            }
        }
    }
    
    //MARK: - UI Configuration Methods
    private func setupUI() {
        title = "🎈FlickTalk"
        navigationItem.hidesBackButton = true
        bottomMessageSenderView.layer.cornerRadius = 8
    }
    
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
    
    private func makeTableViewStableAfterNextLoad(newMessageCount: Int = 20) {
        // 1. Record the current content height and offset
        let previousContentHeight = chatTableView.contentSize.height
        let previousOffset = chatTableView.contentOffset.y
        
        // 2. Insert new data at the top of your data source
        // messages.insert(contentsOf: newMessages, at: 0) - Example data insertion
        
        // 3. Reload data
        chatTableView.reloadData()
        
        // 4. Calculate the content height difference
        let newContentHeight = chatTableView.contentSize.height
        let heightDifference = newContentHeight - previousContentHeight
        
        // 5. Adjust the content offset by the height difference
        chatTableView.contentOffset = CGPoint(x: 0, y: previousOffset + heightDifference)
    }
}


//MARK: - TableView Handling
/// We will not handle UI part in this extension for Table View
extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let messageUser = messages[indexPath.row].sender
        let loggedInUser = Auth.auth().currentUser?.email ?? ""
        let loggedInUserSameAsMessageUser = messageUser == loggedInUser
        lastApperedIndex = indexPath.row
        
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 && isLoading {
            chatLoader.startAnimating()
        } else {
            chatLoader.stopAnimating()
        }
        
        if isInitialLoad && indexPath.row == 1 {
            isInitialLoad = false
            
            return
        } else if indexPath.row == 1 && !isLoading {
            isLoading = true
            
            loadNext()
        }
    }
}

/// Queries
extension ChatViewController {
    
    //MARK: - Data Updation Related Methods
    private func loadInitialMessages() {
        db.collection("messages")
            .order(by: "timeStamp", descending: true)
            .limit(to: 30)
            .getDocuments { [weak self] querySnapshot, error in
                guard let self = self else { return }
                
                if let e = error {
                    guard let _ = Auth.auth().currentUser else { return }
                    
                    self.showAlert(ofType: .externalError(e))
                } else {
                    self.messages = []
                    
                    if let querySnapshot = querySnapshot {
                        let documents = querySnapshot.documents
                        
                        fetchAfterDocument = documents.last
                        
                        for document in documents {
                            let documentData = document.data()
                            
                            let messageModel = MessageModel(
                                sender: documentData["sender"] as? String,
                                body: documentData["body"] as? String,
                                timeStamp: documentData["timeStamp"] as? String
                            )
                            messages.insert(messageModel, at: 0)
                        }
                        
                        print("Initial Load Success, Data is: ", messages)
                        
                        DispatchQueue.main.async {
                            self.chatTableView.reloadData()
                            self.scrollTableViewToBottom()
                        }
                    }
                }
            }
    }
    
    private func loadNext() {
        guard let fetchAfterDocument = fetchAfterDocument else { return }
        
        db.collection("messages")
            .order(by: "timeStamp", descending: true)
            .limit(to: 30)
            .start(afterDocument: fetchAfterDocument)
            .getDocuments { [weak self] querySnapshot, error in
                guard let self = self else { return }
                
                if let e = error {
                    guard let _ = Auth.auth().currentUser else { return }
                    
                    self.showAlert(ofType: .externalError(e))
                } else {
                    if let querySnapshot = querySnapshot {
                        let documents = querySnapshot.documents
                        
                        self.fetchAfterDocument = documents.last
                        
                        /// Logic for pagination stabelisation
                        let firstVisibleIndexPath = chatTableView.indexPathsForVisibleRows?.first
                        
                        for document in documents {
                            let documentData = document.data()
                            
                            let messageModel = MessageModel(
                                sender: documentData["sender"] as? String,
                                body: documentData["body"] as? String,
                                timeStamp: documentData["timeStamp"] as? String
                            )
                            messages.insert(messageModel, at: 0)
                        }
                        
                        chatTableView.reloadData()
                        
                        chatTableView.scrollToRow(at: IndexPath(row: documents.count + (firstVisibleIndexPath?.row ?? 0), section: 0), at: .top, animated: false)
                        isLoading = false
                    }
                }
            }
    }
    
    private func addMessageListener() {
        db.collection("messages")
            .order(by: "timeStamp", descending: true)
            .limit(to: 1)
            .addSnapshotListener { querySnapshot, error in
            if let e = error {
                guard let _ = Auth.auth().currentUser else { return }
                
                self.showAlert(ofType: .externalError(e))
            } else {
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
