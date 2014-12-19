//
//  ViewController.swift
//  nobrackets
//
//  Created by Zach Hobbs on 12/18/14.
//  Copyright (c) 2014 Zach Hobbs. All rights reserved.
//

import UIKit

class EditorViewController: ZSSRichTextEditor {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let html = "<!-- This is an HTML comment --><p>This is a test of the <strong>ZSSRichTextEditor</strong> by <a title=\"Zed Said\" href=\"http://www.zedsaid.com\">Zed Said Studio</a></p>"
        
        // Set the base URL if you would like to use relative links, such as to images.
        self.baseURL = NSURL(string: "http://wikia.com")!
        
        // If you want to pretty print HTML within the source view.
        self.formatHTML = true;
        
        // set the initial HTML for the editor
        self.setHTML(html)
        
        let manager = AFHTTPRequestOperationManager()
        let params = [ "action" : "edit",
            "title" : "About_this_hack",
            "text" : "==Edit from ios #2==",
            "format" : "json",
            "token":"+\\" ]
        
        let baseUrl = "http://nobracketshack.wikia.com/api.php"
        
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

