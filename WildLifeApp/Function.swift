//
//  Function.swift
//  WildLifeApp
//
//  Created by KurtHo on 2016/8/20.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension UIViewController {
    func dismissKeyboard() {
        view.endEditing(true)
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    
    
    
    func alert(_ title: String, contain: String) {
        let alertButton = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: contain, style: .cancel, handler: nil)
        alertButton.addAction(okAction)
        self.present(alertButton, animated: true, completion: nil)
    }
    
    func userInfoAler(_ title: String, value: [UIAlertAction] ) {
        let alertButton = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertButton.addAction(okAction)
        for action in value{
            alertButton.addAction(action)
        }
        self.present(alertButton, animated: true, completion: nil)
    }


    func uploadData(_ values: [AnyHashable: Any] ) {
        let ref = FIRDatabase.database().reference(fromURL: "https://willlifeapp.firebaseio.com/")
        let uid =  Cuser.shareObj.infos.id
        let userRef = ref.child("users").child(uid)
        userRef.updateChildValues(values, withCompletionBlock: {(err, ref) in
            if err != nil {
                print("func upload = err \(err)")
            }
        })
        
    }
    
    
    
    
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func unhideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    
}
