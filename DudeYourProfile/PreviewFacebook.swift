//
//  PreviewFacebook.swift
//  DudeYourProfile
//
//  Created by Andrew Garcia on 4/5/16.
//  Copyright © 2016 Andrew Garcia. All rights reserved.
//

import UIKit
import WebKit

class PreviewFacebook: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    
    @IBOutlet weak var topStatusBarView: UIView!
    
    var webView: WKWebView
    let config = WKWebViewConfiguration()
    let loginScriptURL = NSBundle.mainBundle().pathForResource("addComment", ofType: "js")
    let addCommentMessageHandler = "addComment"
    var commentAdded = false
    
    required init?(coder aDecoder: NSCoder) {
        self.webView = WKWebView(frame: CGRectZero, configuration: config)
        super.init(coder: aDecoder)
        self.webView.navigationDelegate = self
        config.userContentController.addScriptMessageHandler(self, name: addCommentMessageHandler)
        let scriptContent = try? String(contentsOfFile:loginScriptURL!, encoding:NSUTF8StringEncoding)
        let script = WKUserScript(source: scriptContent!, injectionTime: .AtDocumentEnd, forMainFrameOnly: true)
        config.userContentController.addUserScript(script)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    func setUpView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint(item: webView, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: 0)
        let pinTop = NSLayoutConstraint(item: webView, attribute: .Top, relatedBy: .Equal,
                                        toItem: view, attribute: .Top, multiplier: 1.0, constant: 20)
        let width = NSLayoutConstraint(item: webView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0)
        view.addConstraints([height, width, pinTop])
        
        webView.loadRequest(NSURLRequest(URL:NSURL(string:"https://m.facebook.com" + DataService.shared.victim.profileLink)!))
        
//        self.view.bringSubviewToFront(commentTextView)
//        self.view.bringSubviewToFront(bottomPanel)
        self.view.bringSubviewToFront(topStatusBarView)
//        self.view.bringSubviewToFront(takeScreenShotView)
//        commentTextView.hidden = true
//        takeScreenShotView.hidden = true
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        
    }

}
