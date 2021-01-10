//
//  Alert.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import UIKit

struct Alert {
    func loadingAlert() -> UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        
        return alert
    }
    
    func errorAlert(message mes: String) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: mes, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
}
