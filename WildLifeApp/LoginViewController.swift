//
//  LoginViewController.swift
//  WildLifeApp
//
//  Created by KurtHo on 2016/8/12.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    
    @IBOutlet weak var fbButton: FBSDKLoginButton!

    var loginButton: FBSDKLoginButton = FBSDKLoginButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if user != nil {
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                let homeView: UIViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("HomeView")
                self.presentViewController(homeView, animated: true, completion: nil)
            }
            
        }
        
        
        
        
        
        loginButton.center = self.view.center
        self.view!.addSubview(loginButton)
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        self.loginButton.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)  {
        let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
            print("user logged in firebase")
        }
        print("User log in*****")
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
        print("User did log out *****")
    }


}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
