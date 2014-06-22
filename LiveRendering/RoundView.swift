//
//  RoundView.swift
//  ToritoriBattle
//
//  Created by Kohei Iwasaki on 2014/06/21.
//  Copyright (c) 2014 Kohei Iwasaki. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable class RoundView: UIView {
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
    didSet {
        layer.borderWidth = borderWidth
    }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSizeMake(0.0, 0.0) {
    didSet {
        layer.shadowRadius = 3;
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSizeMake(0, 0)
        layer.shadowPath = UIBezierPath(rect: CGRectMake(-100, -100, bounds.width+100, bounds.height+100)).CGPath
    }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
    didSet {
        layer.cornerRadius = cornerRadius
    }
    }
    
    @IBInspectable var layerBackgroundColor: UIColor = UIColor(){
    didSet {
        layer.backgroundColor = layerBackgroundColor.CGColor
    }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}