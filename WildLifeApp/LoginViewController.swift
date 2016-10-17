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
import GoogleSignIn



class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInDelegate, GIDSignInUIDelegate, UITextFieldDelegate {
    /*!
     @abstract Sent to the delegate when the button was used to login.
     @param loginButton the sender
     @param result The results of the login
     @param error The error (if any) from the login
     */


    var loginButton = FBSDKLoginButton()

    
    
//    @IBOutlet weak var googleView: UIView!
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var fbView: UIView!
    @IBOutlet weak var createAccount: UIButton!
    @IBOutlet weak var signButton: UIButton!
    
    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loadIng: UIActivityIndicatorView!
    
    
    @IBAction func googleSignIn(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signIn()
    }
    
//  testing change fb button icon
    


    
    @IBAction func signButton(_ sender: AnyObject) {
        if signButton.titleLabel?.text == " Sign In " {
            login()
        } else {
            if (accountField.text?.characters.count)! < 8 {
                alert("帳號太短", contain: "知道了")
            } else if (passwordField.text?.characters.count)! < 8 {
                alert("密碼至少要八位數", contain: "知道了")
            }else {
                createAccountFunc()
                print("test instanstiate~~~")
                }
            }
        }
    
    
    @IBAction func createAccount(_ sender: AnyObject) {
        if signButton.titleLabel?.text == " Sign In " {
            signLabel.text = "Sign Up"
            signButton.backgroundColor = UIColor(red: 82/255, green: 190/255, blue: 91/255, alpha: 1)
            signButton.setTitle("Sign Up", for: UIControlState())
            createAccount.setTitle("Already Have Account", for: UIControlState())
            
        }else if signButton.titleLabel?.text == "Sign Up" {
            signLabel.text = "Sign In"
            signButton.backgroundColor = UIColor(red: 4/255, green: 175/255, blue: 200/255, alpha: 1)
            signButton.setTitle(" Sign In ", for: UIControlState())
            createAccount.setTitle("Back To Sign Up", for: UIControlState())
        }
    }
    
    
    //🙄
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
                withError error: Error!) {
        self.loadIng.startAnimating()

        if let error = error {
            print(error.localizedDescription)
            self.loadIng.stopAnimating()

        }
        let authentication = user.authentication
        let credential = FIRGoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!, accessToken: (authentication?.accessToken)!)
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            print("user log in with google")
        })
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!,
                withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        try! FIRAuth.auth()!.signOut()
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self

        hideKeyboardWhenTappedAround()
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if user != nil {
//                self.userInfos.id = (user?.uid)!
                Cuser.shareObj.infos.id = (user?.uid)!
                
//               從這邊可以儲存uid到user default
                
                let ref = FIRDatabase.database().reference(fromURL: "https://willlifeapp.firebaseio.com/")
                let userReference = ref.child("users").child(Cuser.shareObj.infos.id
                )
                let value = ["email": (FIRAuth.auth()?.currentUser?.email)!]
                print("value~~~~\(value)")
                print("login view current  id~~~ \(Cuser.shareObj.infos.id)")
                userReference.updateChildValues(value, withCompletionBlock: {(err, ref) in
                    if err != nil {
                        print("....",err)
                        return
                    }

                })
                self.saveUserID(Cuser.shareObj.infos.id)
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                let homeView: UIViewController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeView")
                self.present(homeView, animated: true, completion: nil)
                
            }
        }

        
        self.view!.addSubview(self.loginButton)
        self.loginButton.delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.view.layoutIfNeeded()
        self.loginButton.center = self.fbView.center
        signButton.layer.cornerRadius = signButton.frame.height / 6

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//  MARK: - Firebase
//      upload user data

    func createAccountFunc() {
        self.loadIng.startAnimating()
        FIRAuth.auth()?.createUser(withEmail: accountField.text!, password: passwordField.text!, completion: {
            (user: FIRUser?, error) in
            if error != nil {
                self.alert("此帳號已有人使用", contain: "知道了")
                self.loadIng.stopAnimating()
                print("create incorrect")
            } else {
                
                guard let uid = user?.uid else {
                    return
                }
                Cuser.shareObj.infos.id = uid
                print("user create success")
                let ref = FIRDatabase.database().reference(fromURL: "https://willlifeapp.firebaseio.com/")
                let userReference = ref.child("users").child(uid)
                let value = ["email": self.accountField.text!]
                userReference.updateChildValues(value, withCompletionBlock: {(err, ref) in
                    
                    if err != nil {
                        print(err)
                        return
                    }
                })
            }
        })
    }
    
    func login() {
        self.loadIng.startAnimating()
        FIRAuth.auth()?.signIn(withEmail: accountField.text!, password: passwordField.text!, completion: {
            (user: FIRUser?, error) in
            if error != nil {
                self.alert("帳號密碼錯誤", contain: "知道了")
                self.loadIng.stopAnimating()
//                password or email is incorrect
                print("incorrect")
            } else {
                Cuser.shareObj.infos.id = (user?.uid)!
                print("user login success")
            }
        })
    }
    
    
    // user default
    
    func saveUserID(_ uid: String?) {
        let id = UserDefaults.standard
        if uid != nil {
            id.set(uid, forKey: "uid")
            id.synchronize()
        }
        print("logview controller. user id \(uid)")
    }
    
    // facebook login
    
    
    public func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        loadIng.startAnimating()
        if error != nil {
            loadIng.stopAnimating()
        }else if (result.isCancelled) {
            loadIng.stopAnimating()
        }else {
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                print("user logged in firebase")
                
            }
        }
        print("User log in*****")
        
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User did log out *****")
    }
    
}


    





