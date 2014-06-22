//
//  BattleSelectViewController.swift
//  ToritoriBattle
//
//  Created by Kohei Iwasaki on 2014/06/22.
//  Copyright (c) 2014 Kohei Iwasaki. All rights reserved.
//

import UIKit

class BattleSelectViewController: UIViewController, BattleSelectLineDelegate {

    @IBOutlet var scroller: BattleSelectView
    var result:Dictionary<String, AnyObject!>[]?
    var opponents:Dictionary<String, AnyObject!>[]?
    var opponent:Dictionary<String, AnyObject!>?
    var chara:Dictionary<String, AnyObject!>?
    
    init(coder:NSCoder!) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scroller.lineDelegate = self
        SVProgressHUD.showWithStatus("loading...")
        UserManager.getOpponents(
            {(responseObject:AnyObject!) in
                println(responseObject)
                self.opponents = responseObject as? Dictionary<String, AnyObject!>[]
                self.scroller.layoutWithOpponents(responseObject)
            }, failure: {() in
                SVProgressHUD.showErrorWithStatus("error!!")
            })
        
    }
    
    func goToBattle(idx: Int) {
        
        self.opponent = opponents![idx]
        let char_id = self.opponent!["id"]
        
        println(char_id)
        
        let ud = NSUserDefaults.standardUserDefaults()
        let character : AnyObject! = ud.objectForKey("Character")
        self.chara = character as? Dictionary<String, AnyObject!>
        let my_id = self.chara!["id"]
        
        println(my_id)
        
        SVProgressHUD.showWithStatus("loading...")
        
        UserManager.battle(my_id as Int, chara2_id: char_id as Int,
            success: {(responseObject:AnyObject!) in
                
                let response = responseObject as? Dictionary<String, AnyObject!>
                let response2 = response!["attacks"]
                println(response2)
                
                self.result = response2 as? Dictionary<String, AnyObject!>[]
                
                SVProgressHUD.dismiss()
                
                self.performSegueWithIdentifier("Battle", sender: self)

                
            }, failure: {() in
                
                SVProgressHUD.showErrorWithStatus("loading failed.")
                
            })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        let vc = segue.destinationViewController as BattleViewController
        vc.result = self.result
        vc.chara = self.chara
        vc.opponent = self.opponent
    }
    
    @IBAction func back(){
        self.dismissModalViewControllerAnimated(true)
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
