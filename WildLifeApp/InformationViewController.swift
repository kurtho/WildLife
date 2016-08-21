//
//  InformationViewController.swift
//  WildLifeApp
//
//  Created by KurtHo on 2016/8/17.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import UIKit
import Firebase


class InformationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imagePicker = UIImagePickerController()
    var contents = ["Gender", "Place", "Age", "Sport", "Injured History", "Allergy", "Introduction"]
    var test = ["Female", "Taipei", "30", "Canyoning, Climbing", "None", "None", "樂天、好相處、喜歡有趣的事情、對不熟的事物抱持試過再說, 對創業創新懷有熱情,蠻喜歡寫程式的,是條無止盡的路"]
    var myImageRoundColor: String?
    


    
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var camaraButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func invisibleButton(sender: AnyObject) {
        pickImageFromLocal()
    }
    @IBAction func camaraButton(sender: AnyObject) {
        pickImageFromLocal()
    }
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.userInfo.text = test[indexPath.row]
        return cell
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


