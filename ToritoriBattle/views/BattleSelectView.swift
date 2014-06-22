//
//  BattleSelectView.swift
//  ToritoriBattle
//
//  Created by Kohei Iwasaki on 2014/06/22.
//  Copyright (c) 2014 Kohei Iwasaki. All rights reserved.
//

import UIKit

protocol BattleSelectLineDelegate {
    func goToBattle(char_id:Int)
}

class BattleSelectView: MGScrollView {
    
    let section = MGTableBox()
    let imgMargin:CGFloat = 4.0
    let imgSize:CGFloat = 100.0
    let labelMargin:CGFloat = 16.0
    var lineDelegate:BattleSelectLineDelegate?
    
    init(coder:NSCoder!) {
        super.init(coder: coder)
        self.boxes.addObject(section)
    }
    
    func layoutWithOpponents(obj:AnyObject!) {
        
        let opponents = obj as Dictionary<String, AnyObject>[]
        
        for (idx, opponent) in enumerate(opponents) {
            let line = MGLine.lineWithSize(CGSizeMake(self.frame.size.width, imgSize+imgMargin*2)) as MGLine
            
            let view = UIView(frame: CGRectMake(0, 0, self.frame.size.width, line.size.height))
            view.backgroundColor = UIColor.grayColor()
            let imgView = UIImageView(frame: CGRectMake(imgMargin, imgMargin, imgSize, imgSize))
            imgView.layer.cornerRadius = imgSize / 2
            imgView.layer.masksToBounds = true
            
            let picture:AnyObject? = opponent["picture"]
            let picture2:AnyObject? = (picture as Dictionary<String, AnyObject>)["picture"]
            let picURL:AnyObject = (picture2 as Dictionary<String, AnyObject>)["url"]!
            let imgURL = picURL as String
            
            println("imgURL: "+imgURL)
            
            imgView.setImageWithURL(NSURL.URLWithString(imgURL), completed: nil, usingActivityIndicatorStyle:.Gray)
            
            let label = UILabel(frame: CGRectMake(imgSize+imgMargin*2+labelMargin, 0, view.frame.size.width-imgSize-imgMargin*2-labelMargin, line.size.height))
            label.text = (opponent["name"] as AnyObject?) as String
            label.font = UIFont.systemFontOfSize(20.0)
            label.textColor = UIColor.blackColor()
            
            println("label.text: "+label.text)
            
            view.addSubview(imgView)
            view.addSubview(label)
            
            line.leftItems.addObject(view)
            view.tag = idx
            let tap = UITapGestureRecognizer(target: self, action: Selector("tapped:"))
            view.addGestureRecognizer(tap)
            
            section.topLines.addObject(line)
            
        }
        
        self.layout()
        
    }
    
    func tapped(gr:UITapGestureRecognizer){

        println(gr.view.tag)
        lineDelegate!.goToBattle(gr.view.tag)
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}
