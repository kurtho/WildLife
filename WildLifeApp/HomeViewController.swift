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
import SDWebImage

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
//        downloadUrl()
        print("00000~~HomeVC")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
//    func downloadUrl() {
//        let uid = CurrentUser.shareInstance.infos?.id
//        print("uid~~\(uid)")
//        
//        let ref = FIRDatabase.database().reference().child("users").child(uid!)
//        ref.observeEventType(.Value, withBlock: {
//            response in
//            self.user.profileImageUrl = response.value?.objectForKey("profileImageURL") as? String
//            print("22222~~HomeVC \(CurrentUser.shareInstance.userInfo[0])")
//            
//            self.user.name = response.value?.objectForKey("name") as? String
//            self.user.myID = response.value?.objectForKey("userId") as? String
//            
//            
//
//                print("33333~~HomeVC\(CurrentUser.shareInstance.userInfo[0])")
//
//        })
    
//        print("user infor append  123~~~\(self.userInfor)")

//        print("current user .shareinstance . userinfo~ \(CurrentUser.shareInstance.userInfo)")
//    }


}
