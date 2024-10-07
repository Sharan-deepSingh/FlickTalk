//
//  WelcomeViewController.swift
//  Bubbly
//
//  Created by Sharandeep Singh on 04/10/24.
//

import UIKit

class WelcomeViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: - LifeCycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
    }
    
    //MARK: - UI Configuration methods
    private func configureUI() {
        registerButton.layer.cornerRadius = 16
        loginButton.layer.cornerRadius = 16
    }
}
