//
//  UIStoryboardSegue+Destination.swift
//  FruiteApp
//
//  Created by Muneer KK on 07/08/21.
//

import UIKit

extension UIStoryboardSegue {
    
    /// - returns:  The intended `UIViewController` from the segue's destination.
    var intendedDestinationViewController: UIViewController {
        if let navigationController = self.destination as? UINavigationController {
            return navigationController.topViewController!
        }
        return self.destination
    }
}
