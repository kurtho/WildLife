//
//  IntroViewController.swift
//  Bravo
//
//  Created by KurtHo on 2016/8/12.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var nextButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.hidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}



extension IntroViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return IntroContent.contents.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("myCell", forIndexPath: indexPath) as! IntroCollectionViewCell
        cell.myImage.image = UIImage(named: IntroContent.contents[indexPath.row].myImage)
        cell.myLabel.text = IntroContent.contents[indexPath.row].myLabel
        return cell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        return CGSize(width: screenSize.width, height: screenSize.width * 1.5)
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageNum = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        self.pageControl!.currentPage = Int(pageNum)
        if self.pageControl!.currentPage == 2 {
            nextButton.hidden = false
        }
    }
    
    
}



class IntroContent {
    static let contents = [
        IntroContent(myImage: "moon", myLabel: "警告標語一"),
        IntroContent(myImage: "me", myLabel: "注意事項二"),
        IntroContent(myImage: "hualien", myLabel: "使用說明三")
    ]
    let myImage: String
    let myLabel: String
    
    init(myImage: String, myLabel: String ) {
        self.myImage = myImage
        self.myLabel = myLabel
    }
}