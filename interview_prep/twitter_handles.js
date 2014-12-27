/*
Lots of people use @handles in their blog posts away from twitter. So someone might have a post that reads, in part:

<p>  I met @jack today. </p>
It would be much better for twitter if those posts looked like this:

<p>  I met <a href="twitter.com/jack"]]>@jack</a> today. </p>
write a javascript file that they can include on a page, which will transform the page as above.
*/

var find_handles = function() {
    var $body = $('body').html();

    //get an array of all matches
    var handles = $body.match("/\s+@(\w)+\s/g");

    for (var i = 0; i < handles.length; i++) {
        $body = $body.replace("@" + handles[i], "<a href=\"twitter.com/" + handles[i] + "\">@" + handles[i] + "</a>");
    }

    $body.html($body);
};
