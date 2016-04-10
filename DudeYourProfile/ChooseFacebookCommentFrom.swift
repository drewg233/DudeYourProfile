//
//  ChooseFacebookCommentFrom.swift
//  DudeYourProfile
//
//  Created by Andrew Garcia on 4/5/16.
//  Copyright © 2016 Andrew Garcia. All rights reserved.
//

import UIKit
import Spring

class ChooseFacebookCommentFrom: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    
    
    @IBOutlet weak var commentTable: UITableView!
    @IBOutlet weak var topBgView: SpringView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var inSearchMode = false
    var filteredFriends = [Friend]()
    var theVictim: Friend!
    var friends: [Friend]!
    var commentFrom: Friend!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    func setUpView() {
        commentTable.dataSource = self
        commentTable.delegate = self
        searchBar.delegate = self
        
        friends = DataService.shared.friendsList
        commentTable.reloadData()
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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
        if let cell = commentTable.dequeueReusableCellWithIdentifier("FriendTableViewCell", forIndexPath: indexPath) as? FriendTableViewCell where self.friends.count > 0 {
            
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
        commentFrom = friendCell
        DataService.shared.setCommentFrom(commentFrom)
        self.performSegueWithIdentifier("goToPreviewSegue", sender: self)
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
    
    
    
    @IBAction func backButtonCommentFromPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    
}