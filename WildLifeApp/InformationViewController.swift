//
//  InformationViewController.swift
//  WildLifeApp
//
//  Created by KurtHo on 2016/8/17.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imagePicker = UIImagePickerController()
     var infos = Infos.init(name: "", photo: "", skill: [""], content: "", id: 0, place: "", info: "")

    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    
    
    @IBAction func imageButton(sender: AnyObject) {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myView.clipsToBounds = true
        self.myView.layer.cornerRadius = self.myView.frame.size.height / 2
    }
    override func viewWillAppear(animated: Bool) {
        myImage.image = CurrentUser.shareInstance.pic
        print("curr~~~~in view will appear \(CurrentUser.shareInstance.pic)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info["UIImagePickerControllerOriginalImage"] as! UIImage
        CurrentUser.shareInstance.pic = image
        self.myImage.image = image
        UIImageWriteToSavedPhotosAlbum(self.myImage.image!, nil, nil, nil)
        self.dismissViewControllerAnimated(true, completion: nil)
        saveSelectedImage(image)
        print("my share instance ~~~\(CurrentUser.shareInstance.pic)")
    }
    

    
    func saveSelectedImage(image: UIImage) {
        myImage.image = image
        CurrentUser.shareInstance.pic = image
        print("share instance pic ~~~~\(CurrentUser.shareInstance.pic)")
    }

    
}
