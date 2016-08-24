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

    
    
    func uploadDataWithUID(uid: String, values: [NSObject: AnyObject]) {
        let ref = FIRDatabase.database().referenceFromURL("https://willlifeapp.firebaseio.com/")
        let userReference = ref.child("users").child(uid)
        userReference.updateChildValues(values, withCompletionBlock: {(err, ref) in
            if err != nil {
                print(err)
                //  用這方法取得裡面的uid
            }
            print("Upload user photo successfully into Firebase db")
        })
    }
    
    func uploadData(values: [NSObject : AnyObject] ) {
        let ref = FIRDatabase.database().referenceFromURL("https://willlifeapp.firebaseio.com/")
        let uid =  CurrentUser.shareInstance.infos?.id
        let userRef = ref.child("users").child(uid!)
        userRef.updateChildValues(values, withCompletionBlock: {(err, ref) in
            if err != nil {
                print("func upload = err \(err)")
            }
            print("Upload user data successfully into Firbase db")
        })
    }
    
    
    
//    func uploadImage() {
//        let imageName = NSUUID().UUIDString
//        //        亂數產生個string
//        let storageRef = FIRStorage.storage().reference().child("profileImage").child("\(imageName).jpg")
//        //        let storageRef = FIRStorage.storage().reference().child("profileImage").child("kurt.jpg")
//        let uid =  CurrentUser.shareInstance.infos?.id
//        print("user~~~\(uid)")
//        if let uploadData = UIImagePNGRepresentation(self.myImage.image!) {
//            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
//                if error != nil {
//                    print(error)
//                }
//                if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
//                    let values = ["profileImageURL": profileImageUrl]
//                    self.uploadDataWithUID(uid!, values: values)
//                }
//                print(metadata)
//            })
//        }
//        //        之後把他做成簡易的function
//    }
    
    
}
