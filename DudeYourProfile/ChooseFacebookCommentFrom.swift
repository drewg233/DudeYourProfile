//
//  ChooseFacebookCommentFrom.swift
//  DudeYourProfile
//
//  Created by Andrew Garcia on 4/5/16.
//  Copyright © 2016 Andrew Garcia. All rights reserved.
//

import UIKit

class ChooseFacebookCommentFrom: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet weak var commentTable: UITableView!
    
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
        
        friends = DataService.shared.friendsList
        commentTable.reloadData()
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
    
}