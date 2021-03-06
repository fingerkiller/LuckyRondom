//
//  LKCandyEditViewController.swift
//  LuckyRondom
//
//  Created by py on 16/2/3.
//  Copyright © 2016年 py. All rights reserved.
//

import UIKit




@objc protocol CandyEditDelegate:NSObjectProtocol
{
    func editFinshCandy(_ acandy : LKCandy);
}



class LKCandyEditViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ImagePickerDelegate{

    weak  var delegate: CandyEditDelegate?
    
    
    lazy private var imageView:UIImageView = UIImageView()
    lazy private var titleTF:UITextField=UITextField()
    
    

    private var _imagePicker:LKImagePicker?
    
    private var _candy:LKCandy?
    var candy:LKCandy!{
        get
        {
            if(_candy == nil)
            {
                _candy = LKCandy();
            }
            
            return _candy
        }
        set(newValue)
        {
            _candy = newValue
        }
    };
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(LKCandyEditViewController.showImagePicker))
        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(tap);
    }
    
    
    
    
    func showImagePicker()
    {
        
        _imagePicker = LKImagePicker()
        _imagePicker!.delegate = self
        _imagePicker!.showIn(self)
        
        
    }
    
    func imagePickerhasSelectImage(_ image: UIImage) {
        self.imageView.image = image
    }
    
    
    
    @IBAction func saveCandy()
    {
        self.candy.name = self.titleTF.text
        
        if (self.imageView.image != nil)
        {
            if(self.candy.imageName.characters.count<=0)
            {
                self.candy.imageName = NSObject.randomID();
            }
            
            let imagedata = UIImagePNGRepresentation((self.imageView.image)!);
            
            let fileUrl = URL(fileURLWithPath: self.candy.imagePath!)
            
             _=try? imagedata?.write(to: fileUrl, options: .atomic)
            
        }
        
        
       
        
        if ((self.delegate?.responds(to: Selector.init(("editFinshCandy")))) != nil)
        {
            self.delegate?.editFinshCandy(self.candy)
            
        }
        _=self.navigationController?.popViewController(animated: true)
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
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "candyeditCell", for: indexPath)
        
        let subviews:Array! = cell.contentView.subviews
        
        for view in subviews
        {
            view.removeFromSuperview()
        }
        
        if((indexPath as NSIndexPath).row==0)
        {
            self.imageView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
            self.imageView.center = CGPoint(x: self.view.frame.size.width/2.0, y: 150/2.0)
            self.imageView.backgroundColor = UIColor.red
            
            if(self.candy.imageName.characters.count<=0)
            {
                let image = UIImage.init(contentsOfFile: (self.candy.imagePath)!)
                self.imageView.image = image
            }
            
            cell.contentView.addSubview(self.imageView)
            
        }
        else
        {
            self.titleTF.frame = CGRect(x: 15, y: 15, width: self.view.frame.size.width-30, height: 30)
            self.titleTF.placeholder = "名称"
            self.titleTF.text = self.candy.name
            cell.contentView.addSubview(self.titleTF)
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath as NSIndexPath).row==0
        {
            return 150;
        }
        else
        {
            return 60;
        }
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
