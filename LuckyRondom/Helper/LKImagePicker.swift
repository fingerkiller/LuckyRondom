//
//  LKImagePicker.swift
//  LuckyRondom
//
//  Created by py on 16/2/18.
//  Copyright © 2016年 py. All rights reserved.
//

import UIKit


@objc protocol ImagePickerDelegate
{
    
   optional func imagePickerhasSelectImage(image:UIImage)
}


class LKImagePicker: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate,VPImageCropperDelegate {

    
    weak var delegate : ImagePickerDelegate?
    
    private var _contentVC:UIViewController?
    
    func showIn(vc:UIViewController)
    {
        _contentVC = vc
        
        let actionsheet = UIAlertController.init(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet);
        
        let actionphoto = UIAlertAction.init(title: "图库", style: UIAlertActionStyle.Default) { (action) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
            {
                self.showPicVC(UIImagePickerControllerSourceType.PhotoLibrary)
            }
            
            
        }
        
        let actioncamer = UIAlertAction.init(title: "照相", style: UIAlertActionStyle.Default) { (action) -> Void in
            
            if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear)
            {
                self.showPicVC(UIImagePickerControllerSourceType.Camera)
            }
        }
        
        actionsheet.addAction(actionphoto)
        actionsheet.addAction(actioncamer)
        
        vc.presentViewController(actionsheet, animated: true) { () -> Void in
            
        }
    }
    
    private func showPicVC(type:UIImagePickerControllerSourceType)
    {
        let imagePicker = UIImagePickerController.init()
        imagePicker.sourceType = type
        imagePicker.delegate = self
        
        _contentVC?.presentViewController(imagePicker, animated: true, completion: { () -> Void in
            
        })
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        
        picker.dismissViewControllerAnimated(true) { () -> Void in
            
            let image =  info[UIImagePickerControllerOriginalImage] as! UIImage
            
            let screenbounce  = UIScreen.mainScreen().bounds
            
            let vpipic =  VPImageCropperViewController.init(image: image, cropFrame: CGRectMake((screenbounce.width-100)/2, 100, 100, 100), limitScaleRatio: 3);
            
            vpipic.delegate = self
            
            self._contentVC?.presentViewController(vpipic, animated: true, completion: { () -> Void in
                
            })
            
        }
        
    }
    
    func imageCropper(cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
        
        self.delegate?.imagePickerhasSelectImage?(editedImage)
        
        cropperViewController.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    func imageCropperDidCancel(cropperViewController: VPImageCropperViewController!) {
        
        cropperViewController.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
}
