//
//  ChooseFacebookPrankee.swift
//  DudeYourProfile
//
//  Created by Andrew Garcia on 4/5/16.
//  Copyright © 2016 Andrew Garcia. All rights reserved.
//

import UIKit
import Spring
import WebKit

class ChooseFacebookPrankee: UIViewController, WKNavigationDelegate, WKScriptMessageHandler, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    
    @IBOutlet weak var friendsList: UITableView!
    @IBOutlet weak var topBgView: SpringView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var webView: WKWebView
    let config = WKWebViewConfiguration()
    let loginScriptURL = NSBundle.mainBundle().pathForResource("loginScript", ofType: "js")
    let getFriendsURL = NSBundle.mainBundle().pathForResource("getFriendsScript", ofType: "js")
    

    let loginMessageHandler = "facebookLogin"
    let getFriendsMessageHandler = "getFriends"
    var loggedIn = false
    var friends = [Friend]()
    var victim:Friend?
    var inSearchMode = false
    var filteredFriends = [Friend]()
    
    required init?(coder aDecoder: NSCoder) {
        self.webView = WKWebView(frame: CGRectZero, configuration: config)
        super.init(coder: aDecoder)
        self.webView.navigationDelegate = self
        config.userContentController.addScriptMessageHandler(self, name: loginMessageHandler)
        let scriptContent = try? String(contentsOfFile:loginScriptURL!, encoding:NSUTF8StringEncoding)
        let script = WKUserScript(source: scriptContent!, injectionTime: .AtDocumentEnd, forMainFrameOnly: true)
        config.userContentController.addUserScript(script)
        
        config.userContentController.addScriptMessageHandler(self, name: getFriendsMessageHandler)
        let scriptContentFriends = try? String(contentsOfFile:getFriendsURL!, encoding:NSUTF8StringEncoding)
        let scriptFriends = WKUserScript(source: scriptContentFriends!, injectionTime: .AtDocumentEnd, forMainFrameOnly: true)
        config.userContentController.addUserScript(scriptFriends)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func setUpView() {
        friendsList.delegate = self
        friendsList.dataSource = self
        
        searchBar.delegate = self
//        
//        searchBarView.hidden = true
        
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint(item: webView, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: webView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0)
        view.addConstraints([height, width])
        
        webView.loadRequest(NSURLRequest(URL:NSURL(string:"https://m.facebook.com/friends/center/friends")!))
        
    }
    
    func setUpSelectFriendsView() {
        webView.hidden = true
        friendsList.reloadData()
    }
    
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        if (message.name == loginMessageHandler) {
            if (message.body as! NSObject == 1) {
                print("Logged in...")
                loggedIn = true
            }
        } else if (message.name == getFriendsMessageHandler) {
            if (message.body.count > 0) {
                let friendsArry = message.body as? [Dictionary<String, String>]
                for fr in friendsArry! {
                    let newFriend = Friend(dictionary: fr)
                    friends.append(newFriend)
                }
            }
            if (friends.count > 0) {
                DataService.shared.setFriendsList(friends)
                setUpSelectFriendsView()
            }
        }
    }
    
    
    // Table View
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            return self.filteredFriends.count
        }
        return self.friends.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = friendsList.dequeueReusableCellWithIdentifier("FriendTableViewCell", forIndexPath: indexPath) as? FriendTableViewCell where friends.count > 0 {
            let friendCell: Friend!
            
            if inSearchMode {
                friendCell = filteredFriends[indexPath.row]
            } else {
                friendCell = friends[indexPath.row]
            }
            
            cell.configureCell(friendCell)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let friendCell: Friend!
        if inSearchMode {
            friendCell = filteredFriends[indexPath.row]
        } else {
            friendCell = friends[indexPath.row]
        }
        victim = friendCell as Friend!
        DataService.shared.setVictim(victim!)
        performSegueWithIdentifier("commentFromSegue", sender: nil)
    }
    
    
    
    // Search
    func filterContentForSearch(searchText: String, scope: String = "Friend") {
        self.filteredFriends = self.friends.filter({ (friend: Friend) -> Bool in
            let categoryMatch = (scope == "Friend")
            let stringMatch = friend.friendName.rangeOfString(searchText)
            
           return categoryMatch && (stringMatch != nil)
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String?) -> Bool {
        self.filterContentForSearch(searchString!, scope: "Friend")
        if searchString?.characters.count > 0 {
            inSearchMode = true
        } else {
            inSearchMode = false
        }
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearch((self.searchDisplayController?.searchBar.text)!, scope: "Friend")
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController, didHideSearchResultsTableView tableView: UITableView) {
        inSearchMode = false
    }
    
    func searchDisplayController(controller: UISearchDisplayController, willShowSearchResultsTableView tableView: UITableView) {
        tableView.rowHeight = 66.00
        tableView.backgroundColor = UIColor(red:0.13, green:0.15, blue:0.19, alpha:1.0)
        tableView.separatorStyle = .None
    }

    
    
    @IBAction func backButtonPressedChoosePrankee(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    
}
