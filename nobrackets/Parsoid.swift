//
//  Parsoid.swift
//  nobrackets
//
//  Created by Zach Hobbs on 12/18/14.
//  Copyright (c) 2014 Zach Hobbs. All rights reserved.
//

import Foundation


let PARSOID_URL = "http://10.8.34.33:8000/"

class Parsoid {
    
    var base: String
    var title: String
    
    init(base: String, title: String) {
        self.base = base
        self.title = title
    }

    func getURL() -> String {
        return PARSOID_URL + base.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())! + "/" + self.title
    }
    
    func getHTML(rev: Int, success: (String) -> Void, error: ((NSError) -> Void)?) {
        
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()

        let params = [ "oldid" : String(rev)]
        
        manager.GET(getURL(), parameters: params as NSDictionary, success: { (operation, res) -> Void in
            
            success(NSString(data: res as NSData, encoding: NSUTF8StringEncoding)!)
            
        }, failure: { (operation, err) -> Void in
                if error != nil {
                    error!(err)
                }
        })
    }
    
    class func getWikiText(html: String, rev: Int, success: (String) -> Void, error: ((NSError) -> Void)?) {
        
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        

    }
    
    
    
}