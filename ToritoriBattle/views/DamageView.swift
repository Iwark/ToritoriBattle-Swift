//
//  DamageView.swift
//  ToritoriBattle
//
//  Created by Kohei Iwasaki on 2014/06/22.
//  Copyright (c) 2014 Kohei Iwasaki. All rights reserved.
//

import UIKit

class DamageView: UIView {

    var timer:NSTimer?
    var damages = Int[]()
    var hpBar:UIProgressView?
    var imgView:UIImageView?
    var maxhp = 0
    var hp = 0
    var num = 0
    var direction = 1
    
    init(coder:NSCoder!) {
        super.init(coder: coder)
    }
    
    func start(){
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("pop"), userInfo: nil, repeats: true)
        
    }
    
    func pop(){
        if(damages.count <= num){
            timer!.invalidate()
            return
        }
        let damage = damages[num]
        
        if let bar = hpBar {
            hp = hp - damage
            bar.progress = CFloat(Float(hp) / Float(maxhp))
        }
        
        let x = arc4random_uniform(UInt32(self.frame.size.width))
        let y = arc4random_uniform(UInt32(self.frame.size.height))
        
        let label = UILabel(frame: CGRectMake(CGFloat(x), CGFloat(y), 40, 40))
        label.text = String(damage)
        label.font = UIFont.systemFontOfSize(30.0)
        label.textColor = UIColor.redColor()
        
        self.addSubview(label)
        
        UIView.animateWithDuration(1.0, animations: {() in
            
            label.center = CGPointMake(label.center.x, label.center.y - 20)
            label.alpha = 0.0
            
            })
        
        if let view = imgView {
            
            let movement = CGFloat(10 * self.direction)
            
            UIView.animateWithDuration(0.2, animations: {() in
                view.frame = CGRectMake(view.frame.origin.x + movement, view.frame.origin.y, view.frame.size.width, view.frame.size.height)
                view.alpha = 0.5
                }, completion: { (Bool) in
                    UIView.animateWithDuration(0.2, animations: {() in
                        view.frame = CGRectMake(view.frame.origin.x - movement, view.frame.origin.y, view.frame.size.width, view.frame.size.height)
                        view.alpha = 1.0
                        })
                    
            })
            
            if(hp <= 0){
                
                UIView.animateWithDuration(1.0, animations: {() in
                    view.frame = CGRectMake(view.frame.origin.x + movement, view.frame.origin.y, view.frame.size.width, view.frame.size.height)
                    view.alpha = 0.0
                    }, completion: { (Bool) in
                        
                    })
                
            }
        }
        
        
        
        num++
    }

}
