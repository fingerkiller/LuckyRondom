//
//  LKBucketEditViewController.swift
//  LuckyRondom
//
//  Created by py on 16/2/3.
//  Copyright © 2016年 py. All rights reserved.
//

import UIKit

class LKBucketEditViewController: UIViewController,CandyEditDelegate {

    @IBOutlet var bktableview:UITableView!
    
    private  var headerTF:UITextField?
    private var _bucket:LkBucket?
    
    var bucket:LkBucket!{
        get
        {
            if(_bucket == nil)
            {
                _bucket = LkBucket();
            }
            
            return _bucket
        }
        set(newValue)
        {
            _bucket = newValue
        }
    };
    
    
    
    
    
    func editFinshCandy(acandy : LKCandy)
    {
        
        acandy.bucketID = self.bucket.ID
        self.bucket.saveCandy(acandy)
        self.bucket.sourceCandies.addObject(acandy)
        self.bktableview.reloadData()
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.drawHeaderView();
    }
    
    
    
    
    func drawHeaderView()
    {
        
        let headerView = UIImageView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 200))
        headerView.image = UIImage.init(named: "shaizi.jpg")
        headerView.userInteractionEnabled = true;
        
        headerTF = UITextField.init(frame: CGRectMake(0, 200-30, headerView.frame.size.width, 30));
        headerTF?.text = self.bucket.name;
        headerTF?.placeholder = "名称"
        headerView.addSubview(headerTF!)
        
        
        
        bktableview.tableHeaderView = headerView
        
        
    }
    
    
    @IBAction func saveBucket()
    {
        print(self.bucket)
        
        self.bucket?.name = headerTF?.text
        self.bucket?.savetoLocal()
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
             let candy:LKCandy = self.bucket.sourceCandies[indexPath.row] as! LKCandy
            
            LKCandyDao.deleteCandy(candy);
            self.bucket.sourceCandies.removeObjectAtIndex(indexPath.row);
            
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.bucket.sourceCandies.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("candycell", forIndexPath: indexPath)
        
        // Configure the cell...
        let candy:LKCandy = self.bucket.sourceCandies[indexPath.row] as! LKCandy
        
        cell.textLabel?.text = candy.name
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destinationVC:LKCandyEditViewController = segue.destinationViewController as! LKCandyEditViewController;
        
        destinationVC.delegate = self;
    }
    

}
