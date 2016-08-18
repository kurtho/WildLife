//
//  LoginViewController.swift
//  WildLifeApp
//
//  Created by KurtHo on 2016/8/12.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, UITextFieldDelegate {
    var loginButton: FBSDKLoginButton = FBSDKLoginButton()

    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var fbView: UIView!
    @IBOutlet weak var createAccount: UIButton!
    @IBOutlet weak var signButton: UIButton!
    
    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loadIng: UIActivityIndicatorView!
    
    
    
    @IBAction func signButton(sender: AnyObject) {
        if signButton.titleLabel?.text == " Sign In " {
            login()
        } else {
            if accountField.text?.characters.count < 8 {
                accountRepeatly()
            } else if passwordField.text?.characters.count < 8 {
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
            signButton.setTitle(" Sign In ", forState: .Normal)
            createAccount.setTitle("Back To Sign Up", forState: .Normal)
        }
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
//        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
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
//  MARK: - Firebase
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)  {
        loadIng.startAnimating()
        if error != nil {
            loadIng.stopAnimating()
        }else if (result.isCancelled) {
            loadIng.stopAnimating()
        }else {
        let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
            print("user logged in firebase")
            }
        }
        print("User log in*****")
    }
        
//      upload user data
    func handleRegister() {

    }
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User did log out *****")
    }

    
    
    func createAccountFunc() {
        self.loadIng.startAnimating()
        FIRAuth.auth()?.createUserWithEmail(accountField.text!, password: passwordField.text!, completion: {
            user, error in
            if error != nil {
                self.accountAlreadyExist()
                self.loadIng.stopAnimating()
                print("create incorrect")
            } else {
                guard let uid = user?.uid else {
                    return
                }
                print("user create success")
                let ref = FIRDatabase.database().referenceFromURL("https://willlifeapp.firebaseio.com/")
                let userReference = ref.child("users").child(uid)
                let value = ["email": self.accountField.text!]
                userReference.updateChildValues(value, withCompletionBlock: {(err, ref) in
                    if err != nil {
                        print(err)
                        return
                    }
                    print("Saved user successfully into Firebase db")
                })
            }
        })
    }
    
    func login() {
        self.loadIng.startAnimating()
        FIRAuth.auth()?.signInWithEmail(accountField.text!, password: passwordField.text!, completion: {
            user, error in
            if error != nil {
                self.alertWrongPassWordOrAccount()
                self.loadIng.stopAnimating()
//                password or email is incorrect
                print("incorrect")
            } else {
                self.handleRegister()
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
    }
    
    func accountAlreadyExist() {
        let alertButton = UIAlertController(title: "此帳號已有人使用", message: nil, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "知道了", style: .Cancel, handler: nil)
        alertButton.addAction(okAction)
        self.presentViewController(alertButton, animated: true, completion: nil)
    }
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        print("return ~~~~")
//        return true
//    }
//          it is not working
    
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

