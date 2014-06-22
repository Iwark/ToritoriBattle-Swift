//
//  RegistrationViewController.swift
//  ToritoriBattle
//
//  Created by Kohei Iwasaki on 2014/06/21.
//  Copyright (c) 2014 Kohei Iwasaki. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet var nameField:UITextField
    
    init(coder:NSCoder!) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.becomeFirstResponder()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendName(){
        
        UserManager.sendName(nameField.text,
            success:{(responseObject:AnyObject!) in
                if let result = responseObject as? NSDictionary{
                    println(result)
                    SVProgressHUD.showSuccessWithStatus("Succeeded.")
                    self.performSegueWithIdentifier("Main", sender: self)
                }
            },failure:{() in
                SVProgressHUD.showErrorWithStatus("Failed to Send Name.")
            })
        
        SVProgressHUD.showWithStatus("Loading")
        
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
