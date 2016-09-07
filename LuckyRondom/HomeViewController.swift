//
//  HomeViewController.swift
//  LuckyRondom
//
//  Created by py on 16/1/29.
//  Copyright © 2016年 py. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    var bucketsArr:Array<LkBucket>?
    
    
    func refreshView()
    {
        bucketsArr = LKBucketDao.getAllBuckets()
        self.tableView.reloadData();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bucketsArr!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath)

        // Configure the cell...
        let bucket:LkBucket = bucketsArr![(indexPath as NSIndexPath).row]
        
        let image = UIImage.init(contentsOfFile: bucket.headerPath!)
        
        cell.imageView?.image = image;
        
        cell.textLabel?.text = bucket.title
        
        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let bucket:LkBucket = bucketsArr![(indexPath as NSIndexPath).row]
            
            LKBucketDao.deleteBucket(bucket);
            LKCandyDao.deleteAllCandys(from: bucket.ID!);
            bucketsArr?.remove(at: (indexPath as NSIndexPath).row);
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "addBucket")
        {
            
        }
        else
        {
            let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
            let bucket:LkBucket = bucketsArr![(indexPath! as NSIndexPath).row]
            bucket.sourceCandies = LKCandyDao.getAllCandys(from: bucket.ID);
            let randomVC:RandomCollectionViewController = segue.destination as! RandomCollectionViewController
            randomVC.bucket = bucket
        }
        
    }
    

}
