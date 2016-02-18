//
//  LKBucketEditViewController.swift
//  LuckyRondom
//
//  Created by py on 16/2/3.
//  Copyright © 2016年 py. All rights reserved.
//

import UIKit

class LKBucketEditViewController: UIViewController,CandyEditDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,ImagePickerDelegate{

    @IBOutlet var bktableview:UITableView!
    
    
    private  var headerTF:UITextField?
    private var headerImageView:UIImageView?
    private var _bucket:LkBucket?
    private var _imagePicker:LKImagePicker?
    
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
        
        self.bucket.saveCandy(acandy)
        self.bucket.sourceCandies = LKCandyDao.getAllCandys(from: self.bucket.ID);
        self.bktableview.reloadData()
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.drawHeaderView();
    }
    
    
    
    
    
    
    func drawHeaderView()
    {
        
        headerImageView = UIImageView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 200))
        
        if((self.bucket.headerFileName?.characters.count) <= 0)
        {
            headerImageView!.image = UIImage.init(named: "shaizi.jpg")
        }
        else
        {
            let image = UIImage.init(contentsOfFile: bucket.headerPath!)
            headerImageView!.image = image
        }
        headerImageView!.userInteractionEnabled = true;
        let tapges = UITapGestureRecognizer.init(target: self, action: Selector.init("showImagePicker"))
        headerImageView!.addGestureRecognizer(tapges);
        
        
        headerTF = UITextField.init(frame: CGRectMake(0, 200-30, headerImageView!.frame.size.width, 30));
        headerTF?.text = self.bucket.title;
        headerTF?.placeholder = "名称"
        headerImageView!.addSubview(headerTF!)
        
        
        
        bktableview.tableHeaderView = headerImageView
        
        
    }
    
    
    
    func showImagePicker()
    {
        
        _imagePicker = LKImagePicker()
        _imagePicker!.delegate = self
        _imagePicker!.showIn(self)
        

    }
    
    func imagePickerhasSelectImage(image: UIImage) {
        self.headerImageView!.image = image
    }
    
    
    
    @IBAction func saveBucket()
    {
        print(self.bucket)
        
        let imagedata = UIImagePNGRepresentation((headerImageView?.image)!);
        
        if((self.bucket.headerFileName?.characters.count) <= 0)
        {
            self.bucket.headerFileName =  NSObject.randomID()
        }
        
        imagedata?.writeToFile(self.bucket.headerPath!, atomically: true)
        
        self.bucket?.title = headerTF?.text
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
        if(candy.imageName?.characters.count>0)
        {
            let image = UIImage.init(contentsOfFile: (candy.imagePath)!)
            cell.imageView!.image = image
        }
        cell.textLabel?.text = candy.name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier=="editpush")
        {
            let indexPath:NSIndexPath = self.bktableview.indexPathForCell(sender as! UITableViewCell)! as NSIndexPath
            
            let candy:LKCandy = self.bucket.sourceCandies[indexPath.row] as! LKCandy
            
            let destinationVC:LKCandyEditViewController = segue.destinationViewController as! LKCandyEditViewController;
            destinationVC.candy = candy;
            destinationVC.delegate = self;
        }
        else
        {
            let destinationVC:LKCandyEditViewController = segue.destinationViewController as! LKCandyEditViewController;
            
            destinationVC.delegate = self;
        }
        
    }
    

}
