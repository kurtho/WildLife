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
import FBSDKLoginKit

class InformationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    var imagePicker = UIImagePickerController()
    var user = User()
    var tempString = ""
//    let queSerial = dispatch_queue_create("Queue", DISPATCH_QUEUE_SERIAL)
//    let queConCurr = dispatch_queue_create("Queue", DISPATCH_QUEUE_CONCURRENT)
    var contents = ["Gender", "Place", "Age", "Sport" , "Introduction"]

    


    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var camaraButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func SignOut(_ sender: AnyObject) {
        
        try! FIRAuth.auth()!.signOut()
        FBSDKAccessToken.setCurrent(nil)
        let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController : UIViewController = mainStoryBoard.instantiateViewController(withIdentifier: "LogginView")
        self.present(viewController, animated: true, completion: nil)
        //        CurrentUser.shareInstance.infos.sport[0] = ""
        Cuser.shareObj.infos.intro = ""
        Cuser.shareObj.infos.place = ""
        Cuser.shareObj.infos.gender = ""
        Cuser.shareObj.infos.age = ""
        Cuser.shareObj.infos.sport = []
        Cuser.shareObj.sportCheck = [
            false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
        ]
    }
    
    
    
    @IBAction func nameEdit(_ sender: AnyObject) {
        nameTextField.becomeFirstResponder()
    }
    
    @IBAction func idEdit(_ sender: AnyObject) {
        idTextField.becomeFirstResponder()
    }
    
    
    @IBAction func invisibleButton(_ sender: AnyObject) {
        pickImageFromLocal()
    }
    @IBAction func camaraButton(_ sender: AnyObject) {
        pickImageFromLocal()
    }
    
    @IBAction func nameTextField(_ sender: AnyObject) {
        self.uploadData(["name" : nameTextField.text!])
        textFieldDidEndEditing(nameTextField)

    }
    @IBAction func idTextField(_ sender: AnyObject) {
        self.uploadData(["userId" : idTextField.text!])
        textFieldDidEndEditing(idTextField)
    }
    
    
//    🍎🍎🍎
    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = Cuser.shareObj.infos.id
        let ref = FIRDatabase.database().reference().child("users").child(uid).child("email")
        print(ref)
        
        
        print(" Cuser infos sport~ \(Cuser.shareObj.infos.sport)")
        print("current user .shareinstance . userinfo!!!!!!!\(Cuser.shareObj.infos.gender)")
        
        tableView.estimatedRowHeight = 55
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.myImage.layoutIfNeeded()
        self.camaraButton.layoutIfNeeded()
        (self.myImage.clipsToBounds, self.camaraButton.clipsToBounds) = (true, true)
        (self.myImage.layer.cornerRadius, self.camaraButton.layer.cornerRadius) = (self.myImage.frame.size.height / 2, self.camaraButton.frame.size.height / 2)
        camaraButton.layer.borderColor = UIColor.darkGray.cgColor
        camaraButton.layer.borderWidth = 1
//無聊加的邊框判定
        myImage.layer.borderWidth = 2
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadBasic()

//        let uid = Cuser.shareObj.infos.id
//        let ref = FIRDatabase.database().reference().child("users").child(uid)
//        handle = ref.observeEventType(.Value) { (snap: FDataSnapshot) in print (snap.value) }

    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let uid = Cuser.shareObj.infos.id
        let ref = FIRDatabase.database().reference().child("users").child(uid)
        let handle = ref.observe(.value, with: { snapshot in
            print("Snapshot value: \(snapshot.value)")
        })
        ref.removeObserver(withHandle: handle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info["UIImagePickerControllerEditedImage"] as! UIImage
        self.myImage.image = image
        
//        CurrentUser.shareInstance.infos?.photo = image
//        print("我的current user share instance in photo \(CurrentUser.shareInstance.infos?.photo)")
//        UIImageWriteToSavedPhotosAlbum(self.myImage.image!, nil, nil, nil)
        self.dismiss(animated: true, completion: nil)
        myImage.image = image
        uploadImage()
    }
    

    
    func pickImageFromLocal() {
        imagePicker.delegate = self
        //        imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func uploadImage() {
//        let imageName = NSUUID().UUIDString   亂數產生個string

        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpg"
        let storageRef = FIRStorage.storage().reference().child("profileImage").child(Cuser.shareObj.infos.id).child("imageName.jpg")

        let uid =  Cuser.shareObj.infos.id

        print("user~~~\(uid)")
        if let uploadData = UIImagePNGRepresentation(self.myImage.image!) {
            storageRef.put(uploadData, metadata: metaData, completion: { (metadata, error) in
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
        
        

        ref.observeSingleEvent(of: .value, with: {
            snapshot in
            


            self.user.profileImageUrl = (snapshot.value! as AnyObject).object(forKey: "profileImageURL") as? String
            
            self.user.name = (snapshot.value! as AnyObject).object(forKey: "name") as? String
            self.user.myID = (snapshot.value! as AnyObject).object(forKey: "userId") as? String
            
            print("123~\(self.user.name)")
        
            if (snapshot.value! as AnyObject).object(forKey: "gender") as? String == nil {
                Cuser.shareObj.infos.gender = "Male / Female ??"
            }else {
                Cuser.shareObj.infos.gender = ((snapshot.value! as AnyObject).object(forKey: "gender") as! String)
            }
            
            if (snapshot.value! as AnyObject).object(forKey: "place") as? String == nil {
                Cuser.shareObj.infos.place = "Where do you live ??"
            }else {
                Cuser.shareObj.infos.place = ((snapshot.value! as AnyObject).object(forKey: "place") as! String)
            }
            if (snapshot.value! as AnyObject).object(forKey: "age") as? String == nil {
                Cuser.shareObj.infos.age = "Your age ??"
            }else {
                Cuser.shareObj.infos.age = ((snapshot.value! as AnyObject).object(forKey: "age") as! String)
            }
            
            if (snapshot.value! as AnyObject).object(forKey: "sport") as? [String] == nil {
                self.tempString = "Select your sport"
                
            }else {
                Cuser.shareObj.infos.sport = ((snapshot.value! as AnyObject).object(forKey: "sport") as! Array)
                
            }
            
            if (snapshot.value! as AnyObject).object(forKey: "intro") as? String == nil {
                Cuser.shareObj.infos.intro = "Introduce yoursefl ~"
            }else {
                Cuser.shareObj.infos.intro = ((snapshot.value! as AnyObject).object(forKey: "intro") as! String)
            }
            
            
            if Cuser.shareObj.infos.gender == "Female" {
                self.myImage.layer.borderColor = UIColor.red.cgColor
            } else {
                self.myImage.layer.borderColor = UIColor.blue.cgColor
            }
            self.nameTextField.text = self.user.name
            self.idTextField.text = self.user.myID
            
            if self.user.profileImageUrl == nil {
                print("profile image url == nil")
                self.tableView.reloadData()
                return
            }else {
                self.myImage.sd_setImage(with: URL(string: self.user.profileImageUrl!), completed: nil)

                print("44444~~InfoVC\(Cuser.shareObj.infos.gender)")
                self.tableView.reloadData()
            }

        })
  
    }
    
    func showPopUp() {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as!
        PopUpViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    

//  鎖定旋轉
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    

}


// MARK: - extension table view
extension InformationViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! InformationTableViewCell
        cell.myLabel.text = contents[(indexPath as NSIndexPath).row]
//        cell.userInfo.text = userInfor[indexPath.row]
        switch (indexPath as NSIndexPath).row {
        case 0:
            cell.userInfo.text = Cuser.shareObj.infos.gender
        case 1:
            cell.userInfo.text = Cuser.shareObj.infos.place
        case 2:
            cell.userInfo.text = Cuser.shareObj.infos.age
        case 3:
            
            if Cuser.shareObj.infos.sport! == [] {
                cell.userInfo.text = self.tempString
                
            }else {
                cell.userInfo.text = Cuser.shareObj.infos.sport!.joined(separator: ", ")
            }

        case 4:
            
            cell.userInfo.text = Cuser.shareObj.infos.intro
        default:
            break
        }
        
        
        return cell
    }
    


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! InformationTableViewCell
        switch (indexPath as NSIndexPath).row {
        case 0:
            userInfoAler("Gender", value: [
                UIAlertAction(title: "Male", style: .default, handler: { (action: UIAlertAction) in
                    Cuser.shareObj.infos.gender = "Male"

                    print("11111~~InfoVC\(Cuser.shareObj.infos.gender)")
//              下面是5555
                    self.uploadData(["gender": "Male"])
                    self.myImage.layer.borderColor = UIColor.blue.cgColor

                    self.tableView.reloadData()
                }),
                UIAlertAction(title: "Female", style: .default, handler: { (action:UIAlertAction) in
                    Cuser.shareObj.infos.gender = "Female"

                    print("11111~~InfoVC\(Cuser.shareObj.infos.gender)")
                    self.uploadData(["gender": "Female"])
                    self.myImage.layer.borderColor = UIColor.red.cgColor
                    self.tableView.reloadData()
                })
                ]
            )
            return
        case 1:
            showPopUp()
            return
        case 2:
            
            func genderAlert(_ age: String) {
                Cuser.shareObj.infos.age = age
                uploadData(["age" : age])
                tableView.reloadData()
            }
            userInfoAler("Age", value: [
                UIAlertAction(title: "16~20", style: .default, handler: { (action: UIAlertAction) in genderAlert("16~20")}),
                UIAlertAction(title: "21~25", style: .default, handler: { (action: UIAlertAction) in genderAlert("21~25")}),
                UIAlertAction(title: "26~30", style: .default, handler: { (action: UIAlertAction) in genderAlert("26~30")}),
                UIAlertAction(title: "31~35", style: .default, handler: { (action: UIAlertAction) in genderAlert("31~35")}),
                UIAlertAction(title: "36~40", style: .default, handler: { (action: UIAlertAction) in genderAlert("36~40")}),
                UIAlertAction(title: "41~45", style: .default, handler: { (action: UIAlertAction) in genderAlert("41~45")}),
                UIAlertAction(title: "46~50", style: .default, handler: { (action: UIAlertAction) in genderAlert("46~50")}),
                UIAlertAction(title: "51~55", style: .default, handler: { (action: UIAlertAction) in genderAlert("51~55")}),
                
                ])
            return
        case 3:
            performSegue(withIdentifier: "sportCell", sender: Cuser.shareObj.infos.sport)
            
            
            
            return
        case 4:
            performSegue(withIdentifier: "myCell", sender: Cuser.shareObj.infos.intro)
            
            return
        default:
            break
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "myCell" {
            let vc = segue.destination as! EditViewController
            vc.myValue = Cuser.shareObj.infos.intro
        }
    }

    
}


extension InformationViewController {
fileprivate func uploadDataWithUID(_ uid: String, values: [AnyHashable: Any]) {
    let ref = FIRDatabase.database().reference(fromURL: "https://willlifeapp.firebaseio.com/")
    let userReference = ref.child("users").child(uid)
    userReference.updateChildValues(values, withCompletionBlock: {(err, ref) in
        if err != nil {
            print(err)
            }
        print("Upload user photo successfully into Firebase db")
        })
    }
    
    
//    private func observeMessages () {
//        // Start by creating a query that limits the synchronization to the last 25 messages.
//        let messagesQuery = messageRef.queryLimitedToLast(25)
//        
//        // Use the .ChildAdded event to observe for every child item that has been added, and will be added, at the messages location.
//        messagesQuery.observeEventType(FEventType.ChildAdded) { (snapshot:FDataSnapshot!) -> Void in
//            
//            // Extract the senderId and text from snapshot.value.
//            
//            if let id = snapshot.value["senderId"] as? String, text = snapshot.value["text"] as? String {
//                
//                // Call addMessage() to add the new message to the data source.
//                self.addMessage(id, text: text)
//                
//                // Inform JSQMessagesViewController that a message has been received.
//                self.finishReceivingMessage()
//                
//            }
//        }
//    }
    
    
    
}




