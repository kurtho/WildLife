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
    var user = User()
    var userInfor = [String]()
    
    
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
        downloadUrl()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    func downloadUrl() {
        let uid = CurrentUser.shareInstance.infos?.id
        print("uid~~\(uid)")
        
        let ref = FIRDatabase.database().reference().child("users").child(uid!)
        ref.observeEventType(.Value, withBlock: {
            response in
            self.user.profileImageUrl = response.value?.objectForKey("profileImageURL") as? String
            self.user.name = response.value?.objectForKey("name") as? String
            self.user.myID = response.value?.objectForKey("userId") as? String
            
            
            if response.value?.objectForKey("gender") as? String == nil {
                self.userInfor.append("Male / Female")
            }else {
                self.userInfor.append(response.value?.objectForKey("gender") as! String)
            }
            if response.value?.objectForKey("place") as? String == nil {
                self.userInfor.append("Which County do you live?")
            }else {
                self.userInfor.append(response.value?.objectForKey("place") as! String)
            }
            if response.value?.objectForKey("age") as? String == nil {
                self.userInfor.append("21~25?")
            }else {
                self.userInfor.append(response.value?.objectForKey("age") as! String)
            }
            if response.value?.objectForKey("sport") as? String == nil {
                self.userInfor.append("Swimming")
            }else {
                self.userInfor.append(response.value?.objectForKey("sport") as! String)
            }
            if response.value?.objectForKey("intro") as? String == nil {
                self.userInfor.append("Introduce yourself")
            }else {
                self.userInfor.append(response.value?.objectForKey("intro") as! String)
            }
            
            print("user infor append ~~~\(self.userInfor)")
            CurrentUser.shareInstance.userInfo = self.userInfor
            print("current user .shareinstance . userinfo~ \(CurrentUser.shareInstance.userInfo)")
            
            
            
            if self.user.profileImageUrl == nil {
                print("profile image url == nil")
                return
            }else {
//                self.myImage.sd_setImageWithURL(NSURL(string: self.user.profileImageUrl!), completed: nil)
//                self.nameLabel.text = self.user.name
//                self.idLabel.text = self.user.myID
            }
        })
    }


}
