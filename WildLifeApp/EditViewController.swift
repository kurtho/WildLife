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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
