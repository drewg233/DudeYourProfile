//
//  PreviewFacebook.swift
//  DudeYourProfile
//
//  Created by Andrew Garcia on 4/5/16.
//  Copyright © 2016 Andrew Garcia. All rights reserved.
//

import UIKit
import WebKit
import Spring
import iAd

class PreviewFacebook: UIViewController, WKNavigationDelegate, WKScriptMessageHandler, ADBannerViewDelegate {
    
    @IBOutlet weak var topStatusBarView: UIView!
    @IBOutlet weak var commentTextView: SpringView!
    @IBOutlet weak var bottomPanel: UIView!
    @IBOutlet weak var commentTextBox: UITextField!
    @IBOutlet weak var takeScreenShotView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    
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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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
        
        self.doneButton.layer.cornerRadius = 5
        
//        self.view.bringSubviewToFront(commentTextView)
//        self.view.bringSubviewToFront(bottomPanel)
//        self.view.bringSubviewToFront(topStatusBarView)
//        self.view.bringSubviewToFront(takeScreenShotView)
        
        self.interstitialPresentationPolicy = ADInterstitialPresentationPolicy.Automatic
        self.requestInterstitialAdPresentation()
        
        commentTextView.hidden = true
        takeScreenShotView.hidden = true
    }
    
    
    
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        
    }
    
    func openCommentView() {
        if (self.commentTextView.hidden == true) {
            commentTextView.hidden = false
            commentTextView.animation = "squeezeUp"
            commentTextView.animate()
            commentTextBox.becomeFirstResponder()
        } else {
            commentTextView.animation = "squeezeDown"
            commentTextView.animate()
            commentTextView.hidden = true
            commentTextBox.resignFirstResponder()
        }
        
    }
    
    @IBAction func addCommentButtonPressed(sender: AnyObject) {
        openCommentView()
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func commentDoneButtonPressed(sender: AnyObject) {
        DataService.shared.setTheComment(commentTextBox.text!)
        
        let timeAgo = "5 minutes ago"
        
        webView.evaluateJavaScript("storeAndShow( '\(DataService.shared.theComment)', '\(DataService.shared.commentFrom.profileImg)', '\(DataService.shared.commentFrom.friendName)', '\(timeAgo)' )",
                                   completionHandler: nil)
        print("'\(DataService.shared.theComment)', '\(DataService.shared.commentFrom.profileImg)', '\(DataService.shared.commentFrom.friendName)'")
        commentAdded = true
        showScreenShotButton()
        openCommentView()
    }
    
    func showScreenShotButton() {
        self.bottomPanel.hidden = true
        self.takeScreenShotView.hidden = false
    }
    
    @IBAction func takeScreenShotButtonPressed(sender: AnyObject) {
        screenShotMethod()
    }
    
    func snapshot(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func showScreenShotView(timer : NSTimer) {
        self.takeScreenShotView.hidden = false
    }
    
    func screenShotMethod() {
        let screenShot = snapshot(webView)
        
        // let myTimer : NSTimer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(PreviewFacebook.showScreenShotView(_:)), userInfo: nil, repeats: false)

        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let controller = UIActivityViewController(activityItems: [screenShot], applicationActivities: nil)
            controller.excludedActivityTypes = [UIActivityTypePostToFacebook, UIActivityTypePostToTwitter, UIActivityTypePostToWeibo, UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypePostToFlickr, UIActivityTypePostToTencentWeibo, UIActivityTypeMail]
            
            self.presentViewController(controller, animated: true, completion: nil)
        })
    }
    
    

}
