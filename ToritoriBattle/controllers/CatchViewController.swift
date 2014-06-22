//
//  CatchViewController.swift
//  ToritoriBattle
//
//  Created by Kohei Iwasaki on 2014/06/21.
//  Copyright (c) 2014 Kohei Iwasaki. All rights reserved.
//

import UIKit
import QuartzCore

class CatchViewController: UIViewController,
UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    @IBOutlet var imageView:UIImageView
    @IBOutlet var nameField: UITextField
    let picker = UIImagePickerController()
    var nameEditing = false
    
    init(coder:NSCoder!) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.sourceType = .Camera
        picker.showsCameraControls = false
        let overlay = self.storyboard.instantiateViewControllerWithIdentifier("Overlay") as OverlayViewController
        picker.cameraOverlayView = overlay.view
        picker.delegate = self
        
        imageView.layer.cornerRadius = 120.0
        imageView.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("tapped:"))
        overlay.view.addGestureRecognizer(tap)
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("showPicker"), userInfo: nil, repeats: false)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("takenPhoto:"), name: DZNPhotoPickerDidFinishPickingNotification, object: nil)
    }
    
    override func viewDidAppear(animated:Bool) {
    }
    
    @IBAction func editingDidBegin(){
        if(!nameEditing){
            nameEditing = true
            UIView.animateWithDuration(0.5, animations: {
                self.view.center = CGPointMake(self.view.center.x, self.view.center.y - 200)
                })
        }
    }
    
    @IBAction func editingDidEnd(){
        if(nameEditing){
            nameEditing = false
            UIView.animateWithDuration(0.2, animations: {
                self.view.center = CGPointMake(self.view.center.x, self.view.center.y + 200)
                })
        }
    }
    
    @IBAction func retake(){
        editingDidEnd()
        showPicker()
    }
    
    @IBAction func send(){
        if(nameField.text == ""){ return }
        SVProgressHUD.showWithStatus("uploading...")
        let data = UIImageJPEGRepresentation(imageView.image, 0.8)
        let fileName = String(arc4random_uniform(UINT32_MAX))
        
        UserManager.uploadPicture(nameField.text, fileData: data, fileName: fileName,
            success: {(responseObject:AnyObject!) in
                println(responseObject)
                SVProgressHUD.showSuccessWithStatus("succeess!")
                
                let ud = NSUserDefaults.standardUserDefaults()
                ud.setObject(responseObject, forKey: "Character")
                ud.synchronize()
                
                self.dismissModalViewControllerAnimated(true)
            }, failure: {() in
                SVProgressHUD.showErrorWithStatus("error!!")
            })
        
    }
    
    @IBAction func back(){
        self.dismissModalViewControllerAnimated(true)
    }
    
    func showPicker(){
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentViewController(picker, animated:true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: NSDictionary!) {
        println("finished camera.")
        let image = info[UIImagePickerControllerOriginalImage] as UIImage
        let editor = DZNPhotoEditorViewController(image: image, cropMode: .Circular)
        picker.pushViewController(editor, animated:true)
    }
    
    func takenPhoto(center:NSNotification){
        imageView.image = center.userInfo[UIImagePickerControllerEditedImage] as UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tapped(gr:UITapGestureRecognizer) {
        picker.takePicture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
