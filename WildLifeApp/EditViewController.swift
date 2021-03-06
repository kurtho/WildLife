//
//  EditViewController.swift
//  WildLifeApp
//
//  Created by KurtHo on 2016/8/25.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITextViewDelegate {

    var myValue = ""
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myTextView: UITextView!
    
    @IBAction func sendValue(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
        unhideNavigationBar()
        uploadData(["intro" : myValue])
    

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("myArray~~\(myValue)")
        hideKeyboardWhenTappedAround()
        myTextView.text = myValue
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.hidesBarsWhenKeyboardAppears = true

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
//        hideNavigationBar()
    }
    

    func textViewDidEndEditing(_ textView: UITextView) {
        unhideNavigationBar()
        myValue = myTextView.text
        Cuser.shareObj.infos.intro = myValue
        uploadData(["intro" : myValue])
        print("share instance userinfo [4]~~\(Cuser.shareObj.infos.intro)")

    }

}
