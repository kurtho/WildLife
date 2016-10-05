//
//  PopUpViewController.swift
//  WildLifeApp
//
//  Created by KurtHo on 2016/8/28.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    let pickData = [
        ["臺北","新北","桃園","新竹","苗栗","臺中","彰化","南投","雲林","嘉義","臺南","高雄","屏東","台東","花蓮","宜蘭","基隆","澎湖","金門","馬祖"],
        ["市","縣"]
    ]
    
    var myLocation: String = "臺北市"
    
    
    @IBOutlet weak var myPickView: UIPickerView!
    @IBOutlet weak var myLabel: UILabel!
    
    @IBAction func inviButton(_ sender: AnyObject) {
        Cuser.shareObj.infos.place = myLocation
        uploadData(["place" : myLocation])
        print("share instance .user info [1]~~~~\(Cuser.shareObj.infos.place)")
        removeAnimate()
    }
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        showAnimation()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    
    
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
    
    func updateLabel() {
        let firstComponent = pickComponents.location.rawValue
        let secondComponent = pickComponents.county.rawValue
        let one  = pickData[firstComponent][myPickView.selectedRow(inComponent: firstComponent)]
        let two = pickData[secondComponent][myPickView.selectedRow(inComponent: secondComponent)]
        myLabel.text = "居住: \(one)\(two)"
        myLocation = one + two
        
    }
    
    func showAnimation() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    


}


extension PopUpViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        return updateLabel()
    }
    
}
