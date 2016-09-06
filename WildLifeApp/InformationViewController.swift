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


class InformationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    var imagePicker = UIImagePickerController()
    var user = User()
//    var userInfor = ["","","","",""]
    let queSerial = dispatch_queue_create("Queue", DISPATCH_QUEUE_SERIAL)
    let queConCurr = dispatch_queue_create("Queue", DISPATCH_QUEUE_CONCURRENT)
    var contents = ["Gender", "Place", "Age", "Sport" , "Introduction"]


    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var camaraButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    @IBAction func nameEdit(sender: AnyObject) {
        nameTextField.becomeFirstResponder()
    }
    
    @IBAction func idEdit(sender: AnyObject) {
        idTextField.becomeFirstResponder()
    }
    
    
    @IBAction func invisibleButton(sender: AnyObject) {
        pickImageFromLocal()
    }
    @IBAction func camaraButton(sender: AnyObject) {
        pickImageFromLocal()
    }
    
    @IBAction func nameTextField(sender: AnyObject) {
        self.uploadData(["name" : nameTextField.text!])
        textFieldDidEndEditing(nameTextField)

    }
    @IBAction func idTextField(sender: AnyObject) {
        self.uploadData(["userId" : idTextField.text!])
        textFieldDidEndEditing(idTextField)
    }
    



    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(" Cuser infos sport~ \(Cuser.shareObj.infos.sport)")
        self.loadBasic()
        
        
        print("current user .shareinstance . userinfo!!!!!!!\(Cuser.shareObj.infos.gender)")
        
        tableView.estimatedRowHeight = 55
        tableView.rowHeight = UITableViewAutomaticDimension
        (self.myImage.clipsToBounds, self.camaraButton.clipsToBounds) = (true, true)
        (self.myImage.layer.cornerRadius, self.camaraButton.layer.cornerRadius) = (self.myImage.frame.size.height / 2, self.camaraButton.frame.size.height / 2)
        camaraButton.layer.borderColor = UIColor.darkGrayColor().CGColor
        camaraButton.layer.borderWidth = 1
//無聊加的邊框判定
        myImage.layer.borderWidth = 2
        


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
        let uid =  Cuser.shareObj.infos.id
        print("user~~~\(uid)")
        if let uploadData = UIImagePNGRepresentation(self.myImage.image!) {
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error)
                }
                if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
//                    let values = ["profileImageURL": profileImageUrl]
                    self.uploadDataWithUID(uid, values: ["profileImageURL": profileImageUrl])
                    print("3333333~~")
                }
                print(metadata)
            })
        }
    }


    func loadBasic() {
        let uid = Cuser.shareObj.infos.id
        print("~~~ref\(FIRDatabase.database().reference().child("users").child(uid))")
        let ref = FIRDatabase.database().reference().child("users").child(uid)
        ref.observeEventType(.Value, withBlock: {
            response in

            self.user.profileImageUrl = response.value?.objectForKey("profileImageURL") as?String
            self.user.name = response.value?.objectForKey("name") as? String
            self.user.myID = response.value?.objectForKey("userId") as? String
            
            print("123~\(Cuser.shareObj.infos)")
            
            if response.value?.objectForKey("gender") as? String == nil {
                Cuser.shareObj.infos.gender = "Male / Female ??"
            }else {
                Cuser.shareObj.infos.gender = (response.value?.objectForKey("gender") as! String)
            }
            
            if response.value?.objectForKey("place") as? String == nil {
                Cuser.shareObj.infos.place = "Where do you live ??"
            }else {
                Cuser.shareObj.infos.place = (response.value?.objectForKey("place") as! String)
            }
            if response.value?.objectForKey("age") as? String == nil {
                Cuser.shareObj.infos.age = "Your age ??"
            }else {
                Cuser.shareObj.infos.age = (response.value?.objectForKey("age") as! String)
            }
            
            if response.value?.objectForKey("sport") as? [String] == nil {
                
                
            }else {

                Cuser.shareObj.infos.sport = (response.value?.objectForKey("sport") as! Array)
            }
            
            if response.value?.objectForKey("intro") as? String == nil {
                Cuser.shareObj.infos.intro = "Introduce yoursefl ~"
            }else {
                Cuser.shareObj.infos.intro = (response.value?.objectForKey("intro") as! String)
            }
            
            
            if Cuser.shareObj.infos.gender == "Female" {
                self.myImage.layer.borderColor = UIColor.redColor().CGColor
            } else {
                self.myImage.layer.borderColor = UIColor.blueColor().CGColor
            }
            self.nameTextField.text = self.user.name
            self.idTextField.text = self.user.myID
            
            if self.user.profileImageUrl == nil {
                print("profile image url == nil")
                self.tableView.reloadData()
                return
            }else {
                self.myImage.sd_setImageWithURL(NSURL(string: self.user.profileImageUrl!), completed: nil)

                
                print("44444~~InfoVC\(Cuser.shareObj.infos.gender)")
                self.tableView.reloadData()
            }
        })

    }
    
    func showPopUp() {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("sbPopUpID") as!
        PopUpViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)
    }
    
    

//  鎖定旋轉
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    

}


// MARK: - extension table view
extension InformationViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! InformationTableViewCell
        cell.myLabel.text = contents[indexPath.row]
//        cell.userInfo.text = userInfor[indexPath.row]
        switch indexPath.row {
        case 0:
            cell.userInfo.text = Cuser.shareObj.infos.gender
        case 1:
            cell.userInfo.text = Cuser.shareObj.infos.place
        case 2:
            cell.userInfo.text = Cuser.shareObj.infos.age
        case 3:
            
            if Cuser.shareObj.infos.sport! == [] {
                cell.userInfo.text = "Select your sports"
                
            }else {
                cell.userInfo.text = Cuser.shareObj.infos.sport!.joinWithSeparator(", ")
            }


        case 4:
            
            cell.userInfo.text = Cuser.shareObj.infos.intro
        default:
            break
        }
        
        
        return cell
    }
    


    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell") as! InformationTableViewCell
        switch indexPath.row {
        case 0:
            userInfoAler("Gender", value: [
                UIAlertAction(title: "Male", style: .Default, handler: { (action: UIAlertAction) in
                    Cuser.shareObj.infos.gender = "Male"

                    print("11111~~InfoVC\(Cuser.shareObj.infos.gender)")
//              下面是5555
                    self.uploadData(["gender": "Male"])
                    self.myImage.layer.borderColor = UIColor.blueColor().CGColor

                    self.tableView.reloadData()
                }),
                UIAlertAction(title: "Female", style: .Default, handler: { (action:UIAlertAction) in
                    Cuser.shareObj.infos.gender = "Female"

//              下面是5555
                    print("11111~~InfoVC\(Cuser.shareObj.infos.gender)")
                    self.uploadData(["gender": "Female"])
                    self.myImage.layer.borderColor = UIColor.redColor().CGColor
                    self.tableView.reloadData()
                })
                ]
            )
            return
        case 1:
            showPopUp()
            return
        case 2:
            
            func genderAlert(age: String) {
                Cuser.shareObj.infos.age = age
                uploadData(["age" : age])
                tableView.reloadData()
            }
            userInfoAler("Age", value: [
                UIAlertAction(title: "16~20", style: .Default, handler: { (action: UIAlertAction) in genderAlert("16~20")}),
                UIAlertAction(title: "21~25", style: .Default, handler: { (action: UIAlertAction) in genderAlert("21~25")}),
                UIAlertAction(title: "26~30", style: .Default, handler: { (action: UIAlertAction) in genderAlert("26~30")}),
                UIAlertAction(title: "31~35", style: .Default, handler: { (action: UIAlertAction) in genderAlert("31~35")}),
                UIAlertAction(title: "36~40", style: .Default, handler: { (action: UIAlertAction) in genderAlert("36~40")}),
                UIAlertAction(title: "41~45", style: .Default, handler: { (action: UIAlertAction) in genderAlert("41~45")}),
                UIAlertAction(title: "46~50", style: .Default, handler: { (action: UIAlertAction) in genderAlert("46~50")}),
                UIAlertAction(title: "51~55", style: .Default, handler: { (action: UIAlertAction) in genderAlert("51~55")}),
                
                ])
            return
        case 3:
            performSegueWithIdentifier("sportCell", sender: Cuser.shareObj.infos.sport)
            
            
            
            return
        case 4:
            performSegueWithIdentifier("myCell", sender: Cuser.shareObj.infos.intro)
            
            return
        default:
            break
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "myCell" {
            let vc = segue.destinationViewController as! EditViewController
            vc.myValue = Cuser.shareObj.infos.intro
        }
    }

    
}


extension InformationViewController {
private func uploadDataWithUID(uid: String, values: [NSObject: AnyObject]) {
    let ref = FIRDatabase.database().referenceFromURL("https://willlifeapp.firebaseio.com/")
    let userReference = ref.child("users").child(uid)
    userReference.updateChildValues(values, withCompletionBlock: {(err, ref) in
        if err != nil {
            print(err)
            }
        print("Upload user photo successfully into Firebase db")
        })
    }
}




