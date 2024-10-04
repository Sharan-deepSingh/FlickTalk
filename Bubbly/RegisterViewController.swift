//
//  RegisterViewController.swift
//  Bubbly
//
//  Created by Sharandeep Singh on 04/10/24.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - IBActions
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            
            /// Handel error case here later.
            return
        }
        
        let indicator = showLoader()
        
        /// Creation of user or signup process using firebase
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            hideLoader(indicator: indicator)
            
            if let e = error {
                /// Handle error case later
                print("Got error", e.localizedDescription)
            } else {
                /// handle these cases completely later like removing prints etc
                performSegue(withIdentifier: "", sender: self)
                print(result?.description ?? "")
            }
        }
    }
    
    //MARK: - UIConfiguration Methods
    private func configureUI() {
        emailTextField.layer.cornerRadius = 12
        passwordTextField.layer.cornerRadius = 12
        registerButton.layer.cornerRadius = 12
    }
}
