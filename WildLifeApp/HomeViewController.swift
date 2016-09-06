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
//        CurrentUser.shareInstance.infos.sport[0] = ""
        Cuser.shareObj.infos.intro = ""
        Cuser.shareObj.infos.place = ""
        Cuser.shareObj.infos.gender = ""
        Cuser.shareObj.infos.age = ""
        Cuser.shareObj.infos.sport = []
    }
    
    
    @IBAction func alertButton(sender: AnyObject) {
        alert("這是title", contain: "這是內文")
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        readUserID()
        testLabel.text = Cuser.shareObj.infos.id
        
        
        print("current user ~~~\(Cuser.shareObj.infos.id)")
        print("00000~~HomeVC")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readUserID() {
        let id = NSUserDefaults.standardUserDefaults()
        let val = id.stringForKey("uid")

        Cuser.shareObj.infos.id = val!
        print("user id = \(val) ~~~~\(Cuser.shareObj.infos.id)")
        
    }


}
