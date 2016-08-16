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
    var loginButton: FBSDKLoginButton = FBSDKLoginButton()

    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var fbView: UIView!
    @IBOutlet weak var createAccount: UIButton!
    @IBOutlet weak var signButton: UIButton!
    

    
    
    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func signButton(sender: AnyObject) {
        if signButton.titleLabel?.text == " Sign In " {
            login()
            print("test~~~")
        
        }else {
            if passwordField.text?.characters.count < 8 {
            let alertButton = UIAlertController(title: "密碼至少要八位數", message: nil, preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "知道了", style: .Cancel, handler: nil)
                    alertButton.addAction(okAction)
            self.presentViewController(alertButton, animated: true, completion: nil)
    
            }else {
                createAccountFunc()
                }
            }
        }
    

    
    @IBAction func createAccount(sender: AnyObject) {
        if signButton.titleLabel?.text == " Sign In " {
            signLabel.text = "Sign Up"
            signButton.backgroundColor = UIColor(red: 82/255, green: 190/255, blue: 91/255, alpha: 1)
            signButton.setTitle("Sign Up", forState: .Normal)
            createAccount.setTitle("Create Account", forState: .Normal)
            
            
            
        }else if signButton.titleLabel?.text == "Sign Up" {
            signLabel.text = "Sign In"
            signButton.backgroundColor = UIColor(red: 4/255, green: 175/255, blue: 200/255, alpha: 1)
            createAccount.setTitle("Back To Sign Up", forState: .Normal)
        }
        

        
        
//        FIRAuth.auth()?.createUserWithEmail(accountField.text!, password:passwordField.text!, completion: {
//                user, error in
//                    if error != nil {
//                        self.accountRepeatly()
//        //                self.login()
//                        print("123124")
//        //                                means accout has been created
//                    }else {
//                        print("user created")
//                        self.login()
//                    }
//                })
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if user != nil {
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                let homeView: UIViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("HomeView")
                self.presentViewController(homeView, animated: true, completion: nil)
            }
            
        }

        self.loginButton.center = self.fbView.center
        self.view!.addSubview(self.loginButton)
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        self.loginButton.delegate = self
        
    }

    override func viewWillAppear(animated: Bool) {
        self.view.layoutIfNeeded()
        self.loginButton.center = self.fbView.center
        signButton.layer.cornerRadius = signButton.frame.height / 6
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

    
    
    func createAccountFunc() {
        FIRAuth.auth()?.createUserWithEmail(accountField.text!, password: passwordField.text!, completion: {
            user, error in
            if error != nil {
                print("create incorrect")
            } else {
                print("user create success")
            }
        })
    }
    
    func login() {
        FIRAuth.auth()?.signInWithEmail(accountField.text!, password: passwordField.text!, completion: {
            user, error in
            if error != nil {
                self.alertWrongPassWordOrAccount()
                //                password or email is incorrect
                print("incorrect")
            } else {
                print("user login success")
            }
        })
    }
    
    func alertWrongPassWordOrAccount() {
        let alertButton = UIAlertController(title: "帳號或密碼錯誤", message: nil, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "知道了", style: .Cancel, handler: nil)
        alertButton.addAction(okAction)
        self.presentViewController(alertButton, animated: true, completion: nil)
    }

    func accountRepeatly() {
        if accountField.text?.characters.count <= 8 {
            let alert = UIAlertController(title: "帳號太短了", message: nil, preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "知道了", style: .Cancel, handler: nil)
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        let alertButton = UIAlertController(title: "此帳號已有人使用", message: nil, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "知道了", style: .Cancel, handler: nil)
        alertButton.addAction(okAction)
        self.presentViewController(alertButton, animated: true, completion: nil)
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


