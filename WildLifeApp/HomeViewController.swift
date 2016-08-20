//
//  HomeViewController.swift
//  WildLifeApp
//
//  Created by KurtHo on 2016/8/15.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
class HomeViewController: UIViewController {
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    

}
