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

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
    }
    
    
    
    
    func alert(title: String, contain: String) {
        let alertButton = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: contain, style: .Cancel, handler: nil)
        alertButton.addAction(okAction)
        self.presentViewController(alertButton, animated: true, completion: nil)
    }
    
    func userInfoAler(title: String, value: [UIAlertAction] ) {
        let alertButton = UIAlertController(title: title, message: nil, preferredStyle: .ActionSheet)
        let okAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertButton.addAction(okAction)
        for action in value{
            alertButton.addAction(action)
        }
        self.presentViewController(alertButton, animated: true, completion: nil)
    }


    func uploadData(values: [NSObject : AnyObject] ) {
        let ref = FIRDatabase.database().referenceFromURL("https://willlifeapp.firebaseio.com/")
        let uid =  Cuser.shareObj.infos.id
        let userRef = ref.child("users").child(uid)
        userRef.updateChildValues(values, withCompletionBlock: {(err, ref) in
            if err != nil {
                print("func upload = err \(err)")
            }
            print("55555~~FuncVC\(Cuser.shareObj.infos.gender)")
        })
    }
    
    
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func unhideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    
}
