//
//  PopUpViewController.swift
//  WildLifeApp
//
//  Created by KurtHo on 2016/8/28.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let pickData = [
        ["臺北","新北","桃園","新竹","苗栗","臺中","彰化","南投","雲林","嘉義","臺南","高雄","屏東","台東","花蓮","宜蘭","基隆","澎湖","金門","馬祖"],
        ["市","縣"]
    ]
    
    var myLocation: String?
    
    
    
    @IBOutlet weak var myPickView: UIPickerView!
    @IBOutlet weak var myLabel: UILabel!
    
    enum pickComponents: Int {
        case location = 0
        case county = 1
    }
    enum PickerComponent:Int{
        case era = 0
        case eraTen = 1
        case month = 2
        case date = 3
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    func updateLabel() {
        let firstComponent = pickComponents.location.rawValue
        let secondComponent = pickComponents.county.rawValue
        let one  = pickData[firstComponent][myPickView.selectedRowInComponent(firstComponent)]
        let two = pickData[secondComponent][myPickView.selectedRowInComponent(secondComponent)]
        myLabel.text = "居住: \(one) \(two)"
        myLocation = one + two
        
    }
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return pickData.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickData[component].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickData[component][row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        return updateLabel()
    }
    

}
