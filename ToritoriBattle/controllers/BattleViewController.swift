//
//  BattleViewController.swift
//  ToritoriBattle
//
//  Created by Kohei Iwasaki on 2014/06/22.
//  Copyright (c) 2014 Kohei Iwasaki. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {

    @IBOutlet var p1ImgView: UIImageView
    @IBOutlet var p1HpBar: UIProgressView
    @IBOutlet var p1NameLabel: UILabel
    @IBOutlet var p2ImgView: UIImageView
    @IBOutlet var p2HpBar: UIProgressView
    @IBOutlet var p2NameLabel: UILabel
    @IBOutlet var p1DamageView: DamageView
    @IBOutlet var p2DamageView: DamageView
    
    var result:Dictionary<String, AnyObject!>[]?
    var chara:Dictionary<String, AnyObject!>?
    var opponent:Dictionary<String, AnyObject!>?
    
    init(coder:NSCoder!) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if let statuses = result {
            println("-- status --")
            println(statuses)
            
            // set images
            setImage(chara!, imgView: p1ImgView)
            setImage(opponent!, imgView: p2ImgView)

            // set labels
            setLabel(chara!, label: p1NameLabel)
            setLabel(opponent!, label: p2NameLabel)

            p1HpBar.progress = 1.0
            p2HpBar.progress = 1.0

            let me = chara!["id"]
            let op = opponent!["id"]

            let myhp = chara!["hitpoints"]
            let ophp = opponent!["hitpoints"]

            p1DamageView.hp = myhp as Int
            p2DamageView.hp = ophp as Int
            p1DamageView.maxhp = myhp as Int
            p2DamageView.maxhp = ophp as Int
            p1DamageView.hpBar = p1HpBar
            p2DamageView.hpBar = p2HpBar
            p1DamageView.imgView = p1ImgView
            p2DamageView.imgView = p2ImgView
            p1DamageView.direction = -1
            p2DamageView.direction = 1
            
            var first = 0
            for status in statuses {
                
                let attacker = status["attacker_id"]
                let damage = status["damage"]
                if me as Int == attacker as Int {
                    // I am the attacker
                    if(first == 0){ first = 1 }
                    p2DamageView.damages += damage as Int
                }else{
                    if(first == 0){ first = 2 }
                    p1DamageView.damages += damage as Int
                }
                
            }
            if(first == 1){
                p1DamageView.start()
                NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("startDamageView:"), userInfo: p2DamageView, repeats: false)
            }else{
                p2DamageView.start()
                NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("startDamageView:"), userInfo: p1DamageView, repeats: false)
            }
            
            
            
        }
        
    }
    
    func startDamageView(timer:NSTimer) {
        let damageView = timer.userInfo as DamageView
        damageView.start()
    }
    
    func setImage(dic:Dictionary<String,AnyObject!>, imgView:UIImageView){
        
        let picture:AnyObject? = dic["picture"]
        let picture2:AnyObject? = (picture as Dictionary<String, AnyObject>)["picture"]
        let picURL:AnyObject = (picture2 as Dictionary<String, AnyObject>)["url"]!
        let imgURL = picURL as String
        
        imgView.layer.cornerRadius = imgView.frame.size.width / 2
        imgView.layer.masksToBounds = true
        imgView.setImageWithURL(NSURL.URLWithString(imgURL), completed: nil, usingActivityIndicatorStyle: .White)
//        imgView.setImageWithURL(NSURL.URLWithString(imgURL))
        imgView.setImageWithURL(NSURL.URLWithString(imgURL), usingActivityIndicatorStyle: .Gray)
    }
    
    func setLabel(dic:Dictionary<String,AnyObject!>, label:UILabel){
        
        let name:AnyObject? = dic["name"]
        label.text = name as String
        
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
