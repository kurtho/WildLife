//
//  HomeViewController.swift
//  WildLifeApp
//
//  Created by KurtHo on 2016/8/15.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import UIKit
import Firebase


class HomeViewController: UIViewController {

    @IBOutlet weak var collectView: UICollectionView!
    @IBOutlet weak var testLabel: UILabel!
        
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        readUserID()
        testLabel.text = Cuser.shareObj.infos.id
        
        
        print("current user ~~~\(Cuser.shareObj.infos.id)")
        print("00000~~HomeVC")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readUserID() {
        let id = UserDefaults.standard
        let val = id.string(forKey: "uid")
        
        Cuser.shareObj.infos.id = val!
        print("user id = \(val) ~~~~\(Cuser.shareObj.infos.id)")
        
    }


}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let width = (UIScreen.mainScreen().bounds.width - 10) / 2
//        let height = (UIScreen.mainScreen().bounds.height) / 3.3
//        let layout = collectView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSizeMake(CGFloat(width), CGFloat(height) )

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! HomeViewCollectionViewCell
        
        cell.cellImage.image = UIImage(named: "hualien")
        

        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 2.0
        cell.layer.cornerRadius = 4
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (indexPath as NSIndexPath).item {
        case 0:
            print("lobby")
            break
        case 1:
            print("my channel")
            break
        default:
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.view.frame.size.width / 2) - 15, height: (self.view.frame.size.width) - 150)
    }
    
}
