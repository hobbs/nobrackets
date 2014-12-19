//
//  ViewController.swift
//  nobrackets
//
//  Created by Zach Hobbs on 12/18/14.
//  Copyright (c) 2014 Zach Hobbs. All rights reserved.
//

import UIKit

class EditorViewController: ZSSRichTextEditor {

    let API_BASE = "http://nobracketshack.wikia.com/api.php"
    let ARTICLE_TITLE = "About_this_hack"
    
    var editToken: String?
    var rev: Int?
    var parsoid: Parsoid?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the base URL if you would like to use relative links, such as to images.
        self.baseURL = NSURL(string: "http://wikia.com")!
        
        // If you want to pretty print HTML within the source view.
        self.formatHTML = true;

        parsoid = Parsoid(base: API_BASE, title: ARTICLE_TITLE)

        // Get article info (rev, token)
        MediaWiki.articleDetails(API_BASE, title: ARTICLE_TITLE, success: { (res) -> Void in
                var pageInfo = ((res["query"] as NSDictionary)["pages"] as NSDictionary)["2135"] as NSDictionary
            
                self.editToken = (pageInfo["edittoken"] as String)
                self.loadArticle(pageInfo["lastrevid"] as Int)
            
            }, error: { (err) -> Void in
                NSLog("Error! %@", err)
            })
        
        //On save
        // Get HTML from zss
        // Get Wikitext from parsoid
        // Save changes
        
    }
    
    func loadArticle(rev: Int) {
        NSLog("Loading article, rev: %d", rev)
        self.rev = rev
        self.parsoid!.getHTML(rev, success: { (html) -> Void in
            self.setHTML(html)
            
        }, error: { (err) -> Void in
            // hackathon so who cares
            NSLog("Error! %@", err)
        })
    }
    
    
    @IBAction func saveArticle(sender: AnyObject) {
        if parsoid == nil || rev == nil {
            return
        }
        
        self.parsoid!.getWikiText(self.getHTML(), rev: self.rev!, success: { (wikitext) -> Void in
            
            // just kill everything above the first H2
            let range = wikitext.rangeOfString("==")
            let raw = wikitext.substringFromIndex(range!.startIndex)

            self.submitWikitext(raw)
            
        }, error: { (err) -> Void in
            NSLog("Error getting wikitext: @%", err)
        })
    }
    
    func submitWikitext(wikitext: String) {
        
        NSLog("Submitting wikitext: %@", wikitext)
        
        MediaWiki.updateArticle(API_BASE, title: ARTICLE_TITLE, text: wikitext, token: editToken!, success: { (res) -> Void in
            NSLog("article updated: %@", res)
        }, error: { (err) -> Void in
            NSLog("update failed: %@", err)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

