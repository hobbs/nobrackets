//
//  MediaWiki.swift
//  nobrackets
//
//  Created by Zach Hobbs on 12/18/14.
//  Copyright (c) 2014 Zach Hobbs. All rights reserved.
//

import Foundation

class MediaWiki {
    
    func articleDetails( base: String, title: String, success: (NSDictionary) -> Void, error: (NSError) -> Void) {
        
        let params = [ "action" : "query", "prop" : "info", "titles" : title, "intoken" : "edit"]
        let manager = AFHTTPRequestOperationManager()
        
        manager.GET(base, parameters: params as NSDictionary, success: { (operation, res) -> Void in
            success(res as NSDictionary)
        }) { (operation, err) -> Void in
            error(err)
        }
    }
    
    func updateArticle( base: String, title: String, text: String, token: String,
        success: (NSDictionary) -> Void, error: (NSError) -> Void) {
            
        let manager = AFHTTPRequestOperationManager()
        let params = [ "action" : "edit",
            "title" : title,
            "text" : text,
            "format" : "json",
            "token":token ]
            
        manager.POST(base, parameters: params as NSDictionary, success: { (operation, res) -> Void in
            <#code#>
        }, failure: <#((AFHTTPRequestOperation!, NSError!) -> Void)!##(AFHTTPRequestOperation!, NSError!) -> Void#>)
            
            
    }
}



