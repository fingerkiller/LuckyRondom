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
    
   @objc optional func imagePickerhasSelectImage(_ image:UIImage)
}


class LKImagePicker: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate,VPImageCropperDelegate {

    
    weak var delegate : ImagePickerDelegate?
    
    private var _contentVC:UIViewController?
    
    func showIn(_ vc:UIViewController)
    {
        _contentVC = vc
        
        let actionsheet = UIAlertController.init(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet);
        
        let actionphoto = UIAlertAction.init(title: "图库", style: UIAlertActionStyle.default) { (action) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)
            {
                self.showPicVC(UIImagePickerControllerSourceType.photoLibrary)
            }
            
            
        }
        
        let actioncamer = UIAlertAction.init(title: "照相", style: UIAlertActionStyle.default) { (action) -> Void in
            
            if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.rear)
            {
                self.showPicVC(UIImagePickerControllerSourceType.camera)
            }
        }
        
        actionsheet.addAction(actionphoto)
        actionsheet.addAction(actioncamer)
        
        vc.present(actionsheet, animated: true) { () -> Void in
            
        }
    }
    
    private func showPicVC(_ type:UIImagePickerControllerSourceType)
    {
        if (UIImagePickerController.isSourceTypeAvailable(type)) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = type
            imagePicker.delegate = self
            
            _contentVC?.present(imagePicker, animated: true, completion: {
                
            })
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        picker.dismiss(animated: true) { () -> Void in
            
            let image =  info[UIImagePickerControllerOriginalImage] as! UIImage
            
            let screenbounce  = UIScreen.main.bounds
            
            let vpipic =  VPImageCropperViewController( image: image, cropFrame: CGRect(x: (screenbounce.width-100)/2, y: 100, width: 100, height: 100), limitScaleRatio: 3);
            
            vpipic?.cropperDelegate = self
            
            self._contentVC?.present(vpipic!, animated: true, completion: { () -> Void in
                
            })
        }
        
    }
    
    
    func imageCropper(_ cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
        
        self.delegate?.imagePickerhasSelectImage?(editedImage)
        
        cropperViewController.dismiss(animated: true) { () -> Void in
            
        }
    }
    
    func imageCropperDidCancel(_ cropperViewController: VPImageCropperViewController!) {
        
        cropperViewController.dismiss(animated: true) { () -> Void in
            
        }
    }
    
}
