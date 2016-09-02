//
//  EditViewController.swift
//  WildLifeApp
//
//  Created by KurtHo on 2016/8/25.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    var myArray = []
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("myArray~~\(myArray)")
        
        myTextView.text = myArray[4] as! String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
