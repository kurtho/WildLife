//
//  IntroViewController.swift
//  Bravo
//
//  Created by KurtHo on 2016/8/12.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import UIKit
import FirebaseAuth
class IntroViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var nextButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isHidden = true
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if user != nil {
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                let homeView: UIViewController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeView")
                self.present(homeView, animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}



extension IntroViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return IntroContent.contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! IntroCollectionViewCell
        cell.myImage.image = UIImage(named: IntroContent.contents[(indexPath as NSIndexPath).row].myImage)
        cell.myLabel.text = IntroContent.contents[(indexPath as NSIndexPath).row].myLabel
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize
    {
        let screenSize: CGRect = UIScreen.main.bounds
        
        return CGSize(width: screenSize.width, height: screenSize.width * 1.5)
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNum = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        self.pageControl!.currentPage = Int(pageNum)
        if self.pageControl!.currentPage == 2 {
            nextButton.isHidden = false
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
