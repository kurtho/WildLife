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
        let id = NSUserDefaults.standardUserDefaults()
        let val = id.stringForKey("uid")
        
        Cuser.shareObj.infos.id = val!
        print("user id = \(val) ~~~~\(Cuser.shareObj.infos.id)")
        
    }


}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        let width = (UIScreen.mainScreen().bounds.width - 10) / 2
//        let height = (UIScreen.mainScreen().bounds.height) / 3.3
//        let layout = collectView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSizeMake(CGFloat(width), CGFloat(height) )

    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("myCell", forIndexPath: indexPath) as! HomeViewCollectionViewCell
        
        cell.cellImage.image = UIImage(named: "hualien")
        
//        cell.layoutIfNeeded()
//        cell.cellImage.layer.cornerRadius = cell.cellImage.frame.size.width / 20
//        cell.cellImage.clipsToBounds = true
        cell.layer.borderColor = UIColor.blackColor().CGColor
        cell.layer.borderWidth = 2.0
        cell.layer.cornerRadius = 4
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.item {
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
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake((self.view.frame.size.width / 2) - 15, (self.view.frame.size.width) - 150)
    }
    
}
