//
//  BaseViewController.swift
//  MAFNews
//
//  Created by Yousef Mutawe on 7/9/19.
//  Copyright © 2019 Motawe. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController , NVActivityIndicatorViewable {
    let activityData = ActivityData()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
    fileprivate func showAlert(withTitle title: String, message: String, complition: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel) { (_) in
            if let complition = complition {
                complition()
            }
        }

        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}


extension BaseViewController: BaseCommunicationHandlerDelegate {

    func showError(message: String, complition: (() -> ())?) {
        showAlert(withTitle: "Error", message: message, complition: complition)
    }

    func showSuccessMessage(message: String, complition: (() -> ())?) {
        showAlert(withTitle: "Success", message: message,complition: complition)
    }

    func addLoadingIndicator() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }

    func removeLoadingIndicator() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }

}
