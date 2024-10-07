//
//  AlertManager.swift
//  FlickTalk
//
//  Created by Sharandeep Singh on 06/10/24.
//

import Foundation

enum AlertType {
    
    case externalError(Error)
    case insufficientData
//    case logOutAlert  Define now option alert for this case
}


struct AlertBody {
    
    let title: String?
    let message: String
    let leftButton: String?
    let rightButton: String?
    
    init(title: String? = nil,
         message: String,
         leftButton: String? = nil,
         rightButton: String? = nil) {
        self.title = title
        self.message = message
        self.leftButton = leftButton
        self.rightButton = rightButton
    }
}


struct Alerts {
    
    static func getAlert(ofType alertType: AlertType) -> AlertBody {
        switch alertType {
            
        case .externalError(let error):
            let alert = AlertBody(title: "External Error", message: error.localizedDescription)
            return alert
        case .insufficientData:
            let alert = AlertBody(title: "Insufficient Data", message: "All fields are required")
            return alert
        }
    }
}
