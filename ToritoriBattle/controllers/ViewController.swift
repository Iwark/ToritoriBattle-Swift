//
//  ViewController.swift
//  ToritoriBattle
//
//  Created by Kohei Iwasaki on 2014/06/21.
//  Copyright (c) 2014 Kohei Iwasaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(animated:Bool) {
        let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("goToNext"), userInfo: nil, repeats: false)
    }
    
    func goToNext(){
        let ud = NSUserDefaults.standardUserDefaults()
        let UUID:String? = ud.objectForKey("UUID") as? String
        if(UUID){
            self.performSegueWithIdentifier("Main", sender: self)
        }else{
            self.performSegueWithIdentifier("Register", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

