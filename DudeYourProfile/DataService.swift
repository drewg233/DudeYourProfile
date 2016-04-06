//
//  DataService.swift
//  DudeYourProfile
//
//  Created by Andrew Garcia on 1/22/16.
//  Copyright © 2016 Andrew Garcia. All rights reserved.
//

import Foundation


class DataService {
    static let shared = DataService()
    
    private var _victim: Friend!
    private var _commentFrom: Friend!
    private var _friendsList: [Friend]!
    private var _theComment: String!
    
    var theComment: String {
        return _theComment
    }
    
    var victim: Friend {
        return _victim
    }
    var commentFrom: Friend {
        return _commentFrom
    }
    
    var friendsList: [Friend] {
        return _friendsList
    }
    
    func setVictim(victim: Friend) {
        self._victim = victim
    }
    
    func setCommentFrom(commentFrom: Friend) {
        self._commentFrom = commentFrom
    }
    
    func setFriendsList(friends: [Friend]) {
        self._friendsList = friends
    }
    
    func setTheComment(theComment: String) {
        self._theComment = theComment
    }

}