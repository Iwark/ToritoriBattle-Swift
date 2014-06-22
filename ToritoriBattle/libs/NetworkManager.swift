//
//  NetworkManager.swift
//  ToritoriBattle
//
//  Created by Kohei Iwasaki on 2014/06/21.
//  Copyright (c) 2014 Kohei Iwasaki. All rights reserved.
//

import UIKit

let baseURL = NSURL.URLWithString("http://tori-tori-server.herokuapp.com")
let manager = AFHTTPRequestOperationManager()

class NetworkManager: NSObject {
    
    class func GET(path:String, success:(AnyObject!)->(), failure:()->()){
        
        let request = manager.requestSerializer.requestWithMethod("GET", URLString: NSURL.URLWithString(path, relativeToURL: baseURL).absoluteString, parameters: nil, error: nil)
        request.addValue(getUUID(), forHTTPHeaderField: "UUID")
        
        let operation = manager.HTTPRequestOperationWithRequest(request
            , success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) in
                
                success(responseObject)
                
                
            }, failure: { (operation:AFHTTPRequestOperation!, responseObject:NSError!) in
                
                println("--- Error while Getting ---")
                println(operation.error)
                failure()
                
            })
        
        manager.operationQueue.addOperation(operation)
        
    }
    
    class func POST(path:String, params:Dictionary<String, Dictionary<String, AnyObject>>, success:(AnyObject!)->(), failure:()->()){
        
        let request = manager.requestSerializer.requestWithMethod("POST", URLString: NSURL.URLWithString(path, relativeToURL: baseURL).absoluteString, parameters: params, error: nil)
        request.addValue(getUUID(), forHTTPHeaderField: "UUID")
        
        let operation = manager.HTTPRequestOperationWithRequest(request
            , success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) in
                
                success(responseObject)
                
                
            }, failure: { (operation:AFHTTPRequestOperation!, responseObject:NSError!) in
                
                println("--- Error while Posting ---")
                println(operation.error)
                failure()
                
            })
        
        manager.operationQueue.addOperation(operation)
        
    }
    
    class func POSTFile(path:String, fileData:NSData, fileName:String, params:Dictionary<String, Dictionary<String, AnyObject>>, success:(AnyObject!)->(), failure:()->()){
        
        func block(formData:AFMultipartFormData!){
            formData.appendPartWithFileData(fileData, name: "filename", fileName: fileName, mimeType: "image/jpeg")
        }
        
        let urlString = NSURL.URLWithString(path, relativeToURL: baseURL).absoluteString
        let request = manager.requestSerializer.multipartFormRequestWithMethod("POST", URLString: urlString, parameters: params, constructingBodyWithBlock: block, error: nil)
        
        request.addValue(getUUID(), forHTTPHeaderField: "UUID")
        
        let operation = manager.HTTPRequestOperationWithRequest(request
            , success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) in
                
                success(responseObject)
                
            }, failure: { (operation:AFHTTPRequestOperation!, responseObject:NSError!) in
                
                println("--- Error while Posting ---")
                println(operation.error)
                failure()
                
            })
        
        manager.operationQueue.addOperation(operation)
        
    }
    
    class func getUUID() -> String{
        let ud = NSUserDefaults.standardUserDefaults()
        let tmpUUID:String? = ud.objectForKey("UUID") as? String
        
        var UUID:String
        
        if tmpUUID != nil {
            UUID = tmpUUID!
        }else{
            UUID = NSUUID.UUID().UUIDString
            ud.setObject(UUID, forKey: "UUID")
            ud.synchronize()
        }
        return UUID
    }
}
