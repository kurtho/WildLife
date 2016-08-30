//
//  HomeViewController.swift
//  WildLifeApp
//
//  Created by KurtHo on 2016/8/15.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit


class HomeViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    
    
    @IBAction func logOut(sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        FBSDKAccessToken.setCurrentAccessToken(nil)
        let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController : UIViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("LogginView")
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    
    @IBAction func alertButton(sender: AnyObject) {
        alert("這是title", contain: "這是內文")
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        saveUserID()
        readUserID()
        testLabel.text = CurrentUser.shareInstance.uid
        
        
        print("current user ~~~\(CurrentUser.shareInstance.uid)")
        print("00000~~HomeVC")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readUserID() {
        let id = NSUserDefaults.standardUserDefaults()
        let val = id.stringForKey("kurt")

        CurrentUser.shareInstance.uid = val
        print("user id = \(val) ~~~~\(CurrentUser.shareInstance.uid)")
        
    }

    func saveUserID() {
        let id = NSUserDefaults.standardUserDefaults()
        if LoginViewController.userid != nil {
        id.setObject(LoginViewController.userid, forKey: "kurt")
        id.synchronize()
        }
        print("logview controller. user id \(LoginViewController.userid)")
        
    }

}
