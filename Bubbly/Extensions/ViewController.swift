//
//  ViewController.swift
//  Bubbly
//
//  Created by Sharandeep Singh on 04/10/24.
//

import UIKit
import KRActivityIndicatorView

extension UIViewController {
    
    func showLoader() -> KRActivityIndicatorView {
        let activityIndicator = KRActivityIndicatorView(colors: [.systemPink])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 60),
            activityIndicator.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        activityIndicator.startAnimating()
        
        return activityIndicator
    }
    
    func hideLoader(indicator: KRActivityIndicatorView) {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
    
    func showAlert(ofType alertType: AlertType) {
        let alertBody = Alerts.getAlert(ofType: alertType)
        let alertController = UIAlertController(title: alertBody.title,
                                                message: alertBody.message,
                                                preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        
        present(alertController, animated: true)
    }
}

