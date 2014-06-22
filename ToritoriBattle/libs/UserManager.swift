//
//  UserManager.swift
//  ToritoriBattle
//
//  Created by Kohei Iwasaki on 2014/06/21.
//  Copyright (c) 2014 Kohei Iwasaki. All rights reserved.
//

import UIKit

class UserManager: NSObject {
    
    class func sendName(name:String!, success:(AnyObject!)->(), failure:()->()){
        let params = ["name":name] as Dictionary<String,AnyObject>
        let param = ["player": params]
        NetworkManager.POST("/players.json", params: param,
            success: success, failure: failure)
    }
    
    class func uploadPicture(name:String!, fileData:NSData, fileName:String, success:(AnyObject!)->(), failure:()->()){
        let file = fileData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.fromRaw(0)!)
        let params = ["name":name] as Dictionary<String,AnyObject>
        let param = ["character": params]
        NetworkManager.POSTFile("/characters.json", fileData: fileData, fileName: fileName, params: param, success: success, failure: failure)
    }
    
    class func getOpponents(success:(AnyObject!)->(), failure:()->()){
        NetworkManager.GET("/characters/others.json", success: success, failure: failure)
    }
    
    class func battle(chara1_id:Int, chara2_id:Int,success:(AnyObject!)->(), failure:()->()){
        let params = ["char1_id":chara1_id, "char2_id":chara2_id] as Dictionary<String,AnyObject>
        let param = ["battle": params]
        NetworkManager.POST("/battles.json", params: param,
            success: success, failure: failure)
    }
    
}
