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




    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    
    
    @IBAction func imageButton(sender: AnyObject) {
        imagePicker.delegate = self
//        imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func uploadButton(sender: AnyObject) {
        let imageName = NSUUID().UUIDString
        let storageRef = FIRStorage.storage().reference().child("profileImage").child("\(imageName).jpg")
//        var user: FIRUser?
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
                    print("upload img ~~~~")
                }
                
                print(metadata)
            })
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myView.clipsToBounds = true
        self.myView.layer.cornerRadius = self.myView.frame.size.height / 2
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
        saveSelectedImage(image)
    }
    

    
    func saveSelectedImage(image: UIImage) {
        myImage.image = image
        }

    
    private func uploadDataWithUID(uid: String, values: [NSObject: AnyObject]) {
        let ref = FIRDatabase.database().referenceFromURL("https://willlifeapp.firebaseio.com/")
        let userReference = ref.child("users").child(uid)
        userReference.updateChildValues(values, withCompletionBlock: {(err, ref) in
            if err != nil {
                print(err)
//  用這方法取得裡面的uid
            }
            print("Saved user successfully into Firebase db")
        })
    }



}
