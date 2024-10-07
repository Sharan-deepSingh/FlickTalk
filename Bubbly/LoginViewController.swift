//
//  LoginViewController.swift
//  FlickTalk
//
//  Created by Sharandeep Singh on 05/10/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: - LifeCycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
    }
    
    //MARK: - IBActions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showAlert(ofType: .insufficientData)
    
            return
        }
        
        let indicator = showLoader()
        
        Auth.auth().signIn(withEmail: email,
                           password: password) { [weak self] authResult, error in
            guard let self = self else { return }

            hideLoader(indicator: indicator)
            
            if let e = error {
                showAlert(ofType: .externalError(e))
                
                return
            }
            
            performSegue(withIdentifier: "ChatViewController", sender: self)
        }
    }
    
    //MARK: - UI Configuration methods
    private func configureUI() {
        emailTextField.layer.cornerRadius = 16
        passwordTextField.layer.cornerRadius = 16
        loginButton.layer.cornerRadius = 16
    }
}
