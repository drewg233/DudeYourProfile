var new_comment;

function storeAndShow(theComment, theImageURL, fromName, timeAgo){
    console.log("The Comment is: " + theComment)
    console.log("The Image URL: " + theImageURL)
    console.log("The Name is: " + fromName)
    addTheComment(theComment, theImageURL, fromName, timeAgo)
}

function addTheComment(theComment, theImageURL, fromName, timeAgo) {
    var test2 = document.getElementsByClassName("tlPrelude")[0];
    new_comment = document.createElement('article');
    new_comment.className = "_56be _4hkg _5rgr async_like _1tl-";
    new_comment.innerHTML = '<div class="_55wo _56bf _58k5"><div><header class="_4g33 _5qc1"><div class="_5s61 _2pii _5i2i _52wc"><div class="_5xu4"><a class="_4prr" href="/BR0NAK?fref=nf&amp;pn_ref=story&amp;_ft_=top_level_post_id.10153631493061672%3Atl_objid.10153631493061672%3Athid.641601671%3A306061129499414%3A2%3A1420099200%3A1451635199%3A352958892475835754"><i class="img profpic" aria-label="Ronak Patel" role="img" style="background:#d8dce6 url(&quot;'+ theImageURL +'&quot;) no-repeat center;background-size:100% 100%;-webkit-background-size:100% 100%;width:40px;height:40px;"></i></a></div></div><div class="_4g34 _5i2i _52we"><div class="_5xu4"><div class="_4g33 _52wc"><div class="_4g34"><h1 class="_52jd _52jb _52jh _5qc3" data-gt="{&quot;tn&quot;:&quot;C&quot;}"><a href="/BR0NAK?fref=nf&amp;pn_ref=story&amp;_ft_=top_level_post_id.10153631493061672%3Atl_objid.10153631493061672%3Athid.641601671%3A306061129499414%3A2%3A1420099200%3A1451635199%3A352958892475835754&amp;__tn__=C"><strong></strong></a><strong><a href="/BR0NAK?fref=nf&amp;pn_ref=story&amp;_ft_=top_level_post_id.10153631493061672%3Atl_objid.10153631493061672%3Athid.641601671%3A306061129499414%3A2%3A1420099200%3A1451635199%3A352958892475835754&amp;__tn__=C">'+ fromName +'</a></strong></h1><div class="_52jc _5qc4 _24u0" data-sigil="m-feed-voice-subtitle"><a href="/story.php?story_fbid=10153631493061672&amp;id=641601671&amp;_ft_=top_level_post_id.10153631493061672%3Atl_objid.10153631493061672%3Athid.641601671%3A306061129499414%3A2%3A1420099200%3A1451635199%3A352958892475835754"><abbr>'+ timeAgo +'</abbr></a><span aria-hidden="true"> · </span><span><span data-sigil="audience-icon"><i class="feedAudienceIcon img sp_yTjHol1jJiK sx_4bff59"></i></span></span></div></div><div class="_5s61 _2pis"><div class="_yff" data-store="{&quot;feedobjectsIdentifiers&quot;:&quot;S:_I641601671:10153631493061672&quot;,&quot;feedContext&quot;:&quot;{\&quot;use_m_feed\&quot;:true,\&quot;m_entstream_source\&quot;:\&quot;timeline\&quot;,\&quot;story_node_id\&quot;:\&quot;u_a_b\&quot;}&quot;}" id="u_a_u" data-sigil="story-popup-causal-init"><a class="sec _4s19" href="#" role="button" aria-haspopup="true" data-sigil="touchable"></a><i class="img sp_yTjHol1jJiK sx_af9ffc" data-sigil="story-popup-context-init"><u>More options</u></i></div></div></div></div></div></header><div class="_5rgt _5msi" data-gt="{&quot;tn&quot;:&quot;*s&quot;}"><span><p>'+ theComment +'</p></span><a class="_5msj" href="/story.php?story_fbid=10153631493061672&amp;id=641601671&amp;_ft_=top_level_post_id.10153631493061672%3Atl_objid.10153631493061672%3Athid.641601671%3A306061129499414%3A2%3A1420099200%3A1451635199%3A352958892475835754&amp;__tn__=%2As"></a></div></div><footer class="_22rc"><div class="_2ip_" id="feedback_inline_10153631493061672" data-sigil="mufi-inline"><div class="_2og4 slimLike _15kj _34qc" id="counts_feedback_inline_10153631493061672"><a href="/story.php?story_fbid=10153631493061672&amp;id=641601671&amp;_ft_=top_level_post_id.10153631493061672%3Atl_objid.10153631493061672%3Athid.641601671%3A306061129499414%3A2%3A1420099200%3A1451635199%3A352958892475835754" data-sigil="feed-ufi-trigger"><span class="_28-d" id="u_a_1h"><span class="like_def _28wy">37 Likes</span><span class="cmt_def _28wy">1 Comment</span></span></a></div><div class="_52jh _4g33 _15kk _15ks _15km" data-sigil="ufi-inline-actions"><div class="_52jj _15kl _4g34"><a class="_15ko touchable" href="/a/like/inline.php?feedbackinline=1&amp;chainingEnabled=1&amp;ul&amp;shareID=10153631493061672&amp;fs=0&amp;actionsource=timeline&amp;ft_ent_identifier=10153631493061672&amp;av=100008578868759&amp;gfid=AQC3y_U_HuvBUISs&amp;_ft_=top_level_post_id.10153631493061672%3Atl_objid.10153631493061672%3Athid.641601671%3A306061129499414%3A2%3A1420099200%3A1451635199%3A352958892475835754" id="u_a_18" data-sigil="touchable ufi-inline-like" data-autoid="autoid_74">Like</a></div><div class="_52jj _15kl _4g34"><a class="_15kq" href="#!/story.php?story_fbid=10153631493061672&amp;id=641601671&amp;fs=0&amp;_ft_=top_level_post_id.10153631493061672%3Atl_objid.10153631493061672%3Athid.641601671%3A306061129499414%3A2%3A1420099200%3A1451635199%3A352958892475835754" data-sigil="feed-ufi-focus feed-ufi-trigger ufiCommentLink mufi-composer-focus">Comment</a></div><div class="_52jj _15kl _4g34"><a class="_15kr" data-store="{&quot;reshare_post&quot;:false,&quot;share_id&quot;:&quot;10153631493061672&quot;,&quot;feedback_source&quot;:0,&quot;internal_preview_image_id&quot;:null,&quot;behavior&quot;:&quot;custom&quot;}" href="/sharer.php?fs=0&amp;sid=10153631493061672&amp;_ft_=top_level_post_id.10153631493061672%3Atl_objid.10153631493061672%3Athid.641601671%3A306061129499414%3A2%3A1420099200%3A1451635199%3A352958892475835754" data-sigil="share-popup">Share</a></div></div></div></footer></div>';
    
    test2.appendChild(new_comment);
    test2.scrollIntoView()
}




