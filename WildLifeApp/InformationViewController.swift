//
//  InformationViewController.swift
//  WildLifeApp
//
//  Created by KurtHo on 2016/8/17.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class InformationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imagePicker = UIImagePickerController()
    var myImageRoundColor: String?
    var user = User()
    var userInfo = UserInfo()
    
    var contents = ["Gender", "Place", "Age", "Sport" , "Introduction"]
    var test = ["Female", "Taipei", "30", "Canyoning, Climbing", "樂天、好相處、喜歡有趣的事情、對不熟的事物抱持試過再說, 對創業創新懷有熱情,蠻喜歡寫程式的,是條無止盡的路"]
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var camaraButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func nameEdit(sender: AnyObject) {
        
    }
    
    @IBAction func idEdit(sender: AnyObject) {
    }
    
    
    @IBAction func invisibleButton(sender: AnyObject) {
        pickImageFromLocal()
    }
    @IBAction func camaraButton(sender: AnyObject) {
        pickImageFromLocal()
    }
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
            downloadUrl()
        print("response value~~~~ \(self.user.profileImageUrl)")

        tableView.estimatedRowHeight = 55
        tableView.rowHeight = UITableViewAutomaticDimension
        (self.myImage.clipsToBounds, self.camaraButton.clipsToBounds) = (true, true)
        (self.myImage.layer.cornerRadius, self.camaraButton.layer.cornerRadius) = (self.myImage.frame.size.height / 2, self.camaraButton.frame.size.height / 2)
        camaraButton.layer.borderColor = UIColor.darkGrayColor().CGColor
        camaraButton.layer.borderWidth = 1
//無聊加的邊框判定
        myImage.layer.borderWidth = 2
        myImageRoundColor = test[0]
        if myImageRoundColor == "Female" {
            myImage.layer.borderColor = UIColor.redColor().CGColor
        } else {
            myImage.layer.borderColor = UIColor.blueColor().CGColor
        }
    }
    override func viewWillAppear(animated: Bool) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info["UIImagePickerControllerEditedImage"] as! UIImage
        self.myImage.image = image
        
//        CurrentUser.shareInstance.infos?.photo = image
//        print("我的current user share instance in photo \(CurrentUser.shareInstance.infos?.photo)")
//        UIImageWriteToSavedPhotosAlbum(self.myImage.image!, nil, nil, nil)
        self.dismissViewControllerAnimated(true, completion: nil)
        myImage.image = image
        uploadImage()
    }
    

    
    func pickImageFromLocal() {
        imagePicker.delegate = self
        //        imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func uploadImage() {
        let imageName = NSUUID().UUIDString
//        亂數產生個string
        let storageRef = FIRStorage.storage().reference().child("profileImage").child("\(imageName).jpg")
//        let storageRef = FIRStorage.storage().reference().child("profileImage").child("kurt.jpg")
        let uid =  CurrentUser.shareInstance.infos?.id
        print("user~~~\(uid)")
        if let uploadData = UIImagePNGRepresentation(self.myImage.image!) {
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error)
                }
                if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                    let values = ["profileImageURL": profileImageUrl]
                    self.uploadDataWithUID(uid!, values: values)
                }
                print(metadata)
            })
        }
//        之後把他做成簡易的function
    }

    
    func downloadUrl() {
        let uid = CurrentUser.shareInstance.infos?.id
        let ref = FIRDatabase.database().reference().child("users").child(uid!)
        ref.observeEventType(.Value, withBlock: {
            response in
            self.user.profileImageUrl = response.value?.objectForKey("profileImageURL") as? String
            self.user.name = response.value?.objectForKey("name") as? String
            self.user.myID = response.value?.objectForKey("userId") as? String
            
            self.userInfo.gender = response.value?.objectForKey("gender") as? String
            self.userInfo.place = response.value?.objectForKey("place") as? String
            self.userInfo.age = response.value?.objectForKey("age") as? String
            self.userInfo.sport = response.value?.objectForKey("sport") as? [String]
            self.userInfo.intorduction = response.value?.objectForKey("intro") as? String
            
            
            
            if self.user.profileImageUrl == nil {
                print("profile image url == nil")
                return
            }else {
                self.myImage.sd_setImageWithURL(NSURL(string: self.user.profileImageUrl!), completed: nil)
                self.nameLabel.text = self.user.name
                self.idLabel.text = self.user.myID
            }
        })
    }


    
    

}

extension InformationViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! InformationTableViewCell
        cell.myLabel.text = contents[indexPath.row]
//        cell.userInfo.text = test[indexPath.row]
        cell.userInfo.text = userInfo.gender
        return cell
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            userInfoAler("Gender", value: [
                UIAlertAction(title: "Male", style: UIAlertActionStyle.Default, handler: nil),
                UIAlertAction(title: "Female", style: UIAlertActionStyle.Default, handler: nil)] )
//            let cell = tableView.dequeueReusableCellWithIdentifier("myCell") as! InformationTableViewCell
//            cell.userInfo.text = user.gender
            downloadUrl()
            return
        case 1:
            
            return
        case 2:
            userInfoAler("Age", value: [
                UIAlertAction(title: "16~20", style: .Default, handler: nil),
                UIAlertAction(title: "21~25", style: .Default, handler: nil),
                UIAlertAction(title: "26~30", style: .Default, handler: nil),
                UIAlertAction(title: "31~35", style: .Default, handler: nil),
                UIAlertAction(title: "36~40", style: .Default, handler: nil),
                UIAlertAction(title: "41~45", style: .Default, handler: nil),
                UIAlertAction(title: "46~50", style: .Default, handler: nil),
                UIAlertAction(title: "51~55", style: .Default, handler: nil),
                UIAlertAction(title: "56~60", style: .Default, handler: nil)
                ])
            return
        default:
            break
        }
        
    }
    
    

    

}







//    private func uploadDataWithUID(uid: String, values: [NSObject: AnyObject]) {
//        let ref = FIRDatabase.database().referenceFromURL("https://willlifeapp.firebaseio.com/")
//        let userReference = ref.child("users").child(uid)
//        userReference.updateChildValues(values, withCompletionBlock: {(err, ref) in
//            if err != nil {
//                print(err)
////  用這方法取得裡面的uid
//            }
//            print("Saved user successfully into Firebase db")
//        })
//    }


