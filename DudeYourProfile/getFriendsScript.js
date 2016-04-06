var friendsWrapper = document.querySelector('#friends_center_main')
var friends = friendsWrapper.querySelectorAll('._55wq')


function extractText( str ){
    var ret = "";
    if ( /"/.test( str ) ){
        ret = str.match( /"(.*?)"/ )[1];
    } else {
        ret = str;
    }
    return ret;
}

function parseFriends() {
        friends_array = [];
        console.log("The friends length is: " + friends.length);
    for (var i = 0; i < friends.length; i++) {
        var friend = friends[i];
        var friendName = friend.querySelector('h3._52jh._5pxc a').textContent;
        var profileImg = friend.querySelector('i.img.profpic').getAttribute('style');
        var profileImage = extractText(profileImg)
        var profileLink = friend.querySelector('h3._52jh._5pxc a').getAttribute('href');
        friends_array.push({'profileImg' : profileImage, 'friendName' : friendName, 'profileLink' : profileLink});
    }
    
    return friends_array
}

var friendsList = parseFriends();
var getFriends = window.webkit.messageHandlers.getFriends
getFriends.postMessage(friendsList)