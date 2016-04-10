
//  FriendTableViewCell.swift
//  DudeYourProfile
//
//  Created by Andrew Garcia on 1/21/16.
//  Copyright © 2016 Andrew Garcia. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!

    func configureCell(friend: Friend) {
      let url = NSURL(string: friend.profileImg)
      if let data = NSData(contentsOfURL: url!) {
            self.profileImage.image = UIImage(data: data)
            self.profileImage.layer.cornerRadius = profileImage.frame.height/2
            self.profileImage.layer.masksToBounds = true
      }
      friendName.text = friend.friendName
    }
    
    

}
