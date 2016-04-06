//
//  Friend.swift
//  testwebview
//
//  Created by Andrew Garcia on 1/21/16.
//  Copyright © 2016 Andrew Garcia. All rights reserved.
//

import Foundation

class Friend: NSObject {
    
    var profileImg: String = ""
    var friendName: String = ""
    var profileLink: String = ""
    
    init(dictionary: Dictionary<String, String>) {
        self.profileImg = dictionary["profileImg"]!
        self.friendName = dictionary["friendName"]!
        self.profileLink = dictionary["profileLink"]!
        super.init()
    }
    
}