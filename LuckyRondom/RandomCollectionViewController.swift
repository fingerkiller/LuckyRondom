//
//  RandomCollectionViewController.swift
//  LuckyRondom
//
//  Created by py on 16/2/1.
//  Copyright © 2016年 py. All rights reserved.
//

import UIKit

private let reuseIdentifier = "randomCell"

class RandomCollectionViewController: UICollectionViewController {

    
    
    
    var  bucket:LkBucket?
    
    
    
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(LKCandyCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(UINib(nibName: "LKCandyCollectionViewCell", bundle: nil) ,forCellWithReuseIdentifier: reuseIdentifier)
        
        let collectionFlowLayout : UICollectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        
        collectionFlowLayout.minimumInteritemSpacing = 10;
        collectionFlowLayout.minimumLineSpacing = 10
        collectionFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        let screenbounce  = UIScreen.main.bounds
        
        collectionFlowLayout.itemSize = CGSize(width: (screenbounce.size.width-50)/3.0, height: (screenbounce.size.width-50)/3.0)
//        self.collectionViewLayout
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?)
    {
        
        self.bucket?.rollCandy();
        
        let candy:LKCandy = self.bucket?.resultCandies!.firstObject as! LKCandy;
        
        let alert = UIAlertController.init(title: candy.name, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let alertaction = UIAlertAction.init(title: "ok", style: UIAlertActionStyle.cancel) { (UIAlertAction) -> Void in
            
        }
        
        alert.addAction(alertaction);
        
        self.present(alert, animated: true) { () -> Void in
            
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if(segue.identifier=="edit")
        {
            let targetVC:LKBucketEditViewController  = segue.destination as! LKBucketEditViewController
            
            targetVC.bucket = self.bucket;
            
        }
        
        
    }


    
    
    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        if self.bucket == nil {
            return 0;
        }
        else
        {
            return self.bucket!.sourceCandies.count
        }
        
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LKCandyCollectionViewCell
    
        
        // Configure the cell
        
        let candy:LKCandy = (self.bucket?.sourceCandies[(indexPath as NSIndexPath).row])! as! LKCandy;
        
        cell.titleLb.text = candy.name;
        
        if(candy.imageName != nil)
        {
            let image = UIImage.init(contentsOfFile: (candy.imagePath)!)
            cell.bkImage.image = image;
        }
        else
        {
            cell.backgroundColor = UIColor.orange
        }
        
        
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
