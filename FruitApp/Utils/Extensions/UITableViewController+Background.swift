//
//  UITableViewController+Background.swift
//  FruiteApp
//
//  Created by Muneer KK on 07/08/21.
//

import Foundation
import UIKit

extension UITableViewController {
    
    func setBackgroundMessage(_ message: String?) {
        if let message = message {
            // Display a message when the table is empty
            let messageLabel = UILabel()
            
            messageLabel.text = message
            messageLabel.font = UIFont.systemFont(ofSize: 12)
            messageLabel.textColor = .black
            messageLabel.textAlignment = .center
            messageLabel.sizeToFit()
            
            tableView.backgroundView = messageLabel
            tableView.separatorStyle = .none
        }
        else {
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
        }
    }
}

