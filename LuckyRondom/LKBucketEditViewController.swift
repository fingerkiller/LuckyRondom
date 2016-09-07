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
    
    lazy var  bucket : LkBucket = LkBucket();
    
    
    
    
    
    
    func editFinshCandy(_ acandy : LKCandy)
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
        
        headerImageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200))
        
        if(self.bucket.headerFileName == nil)
        {
            headerImageView!.image = UIImage.init(named: "shaizi.jpg")
        }
        else
        {
            let image = UIImage.init(contentsOfFile: bucket.headerPath!)
            headerImageView!.image = image
        }
        headerImageView!.isUserInteractionEnabled = true;
        let tapges = UITapGestureRecognizer.init(target: self, action: #selector(LKBucketEditViewController.showImagePicker))
        headerImageView!.addGestureRecognizer(tapges);
        
        
        headerTF = UITextField.init(frame: CGRect(x: 0, y: 200-30, width: headerImageView!.frame.size.width, height: 30));
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
    
    func imagePickerhasSelectImage(_ image: UIImage) {
        self.headerImageView!.image = image
    }
    
    
    
    @IBAction func saveBucket()
    {
        print(self.bucket)
        
        let imagedata = UIImagePNGRepresentation((headerImageView?.image)!);
        
        if(self.bucket.headerFileName == nil)
        {
            self.bucket.headerFileName =  NSObject.randomID()
        }
        
        let fileUrl = URL(fileURLWithPath: self.bucket.headerPath!)
       _=try? imagedata?.write(to: fileUrl , options: .atomic)
        
        self.bucket.title = headerTF?.text
        self.bucket.savetoLocal()
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, canEditRowAtIndexPath indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
             let candy:LKCandy = self.bucket.sourceCandies[(indexPath as NSIndexPath).row] as! LKCandy
            
            LKCandyDao.deleteCandy(candy);
            self.bucket.sourceCandies.removeObject(at: (indexPath as NSIndexPath).row);
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.bucket.sourceCandies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "candycell", for: indexPath)
        
        // Configure the cell...
        let candy:LKCandy = self.bucket.sourceCandies[(indexPath as NSIndexPath).row] as! LKCandy
        if(candy.imageName != nil)
        {
            let image = UIImage.init(contentsOfFile: (candy.imagePath)!)
            cell.imageView!.image = image
        }
        cell.textLabel?.text = candy.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath)
    {
        
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier=="editpush")
        {
            let indexPath:IndexPath = self.bktableview.indexPath(for: sender as! UITableViewCell)! as IndexPath
            
            let candy:LKCandy = self.bucket.sourceCandies[(indexPath as NSIndexPath).row] as! LKCandy
            
            let destinationVC:LKCandyEditViewController = segue.destination as! LKCandyEditViewController;
            destinationVC.candy = candy;
            destinationVC.delegate = self;
        }
        else
        {
            let destinationVC:LKCandyEditViewController = segue.destination as! LKCandyEditViewController;
            
            destinationVC.delegate = self;
        }
        
    }
    

}
