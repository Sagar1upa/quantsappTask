//
//  ViewControllerExtension.swift
//  Task
//
//  Created by Sagar Upadhyay on 19/07/21.
//

import UIKit
extension UIViewController {
    //MARK:- Alert View
    func presentShow(withTitle title: String, message : String!){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
