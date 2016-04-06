var friendsWrapper = document.querySelector('#friends_center_main');
var friendsWrapperPresent = 0;

if (friendsWrapper != null) {
    friendsWrapperPresent = 1;
}

var facebookLogin = window.webkit.messageHandlers.facebookLogin
facebookLogin.postMessage(friendsWrapperPresent)