<?php
   require_once '../facebook/facebook.php';
   $config = array(
     'appId' => '279866368741474',
     'secret' => '567a362bf0ac2311b3518badbfec63cf',
   );

   $fb = new Facebook($config);
   $user_id = $fb->getUser();

   if ($user_id) {
     print $user_id;
   } else {
     $params = array(
       //'scope' => 'user_likes,friends_likes,read_stream',
       //'redirect_uri' => 'http://apps.facebook.com/testtestingson/',
     );
     header('Location: ' . $fb->getLoginUrl($params));
   }
?>
