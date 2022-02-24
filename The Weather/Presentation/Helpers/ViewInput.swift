//
//  ViewInput.swift
//  The Weather
//
//  Created by Nikita Gras on 01.02.2021.
//

import UIKit

protocol ViewInput {
    func show(_ error: Error, handler: ((UIAlertAction) -> Void)?)
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?)
}

extension ViewInput {
    func show(_ error: Error, handler: ((UIAlertAction) -> Void)? = nil) {
        showAlert(title: "Error", message: error.localizedDescription, handler: handler)
    }
    
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        guard let vc = self as? UIViewController else { return }
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: handler)
        
        alertVC.addAction(action)
        
        vc.present(alertVC, animated: true, completion: nil)
    }
    
}
