<?php
  define('APP_CODE', '5ddb579b-e110-408b-8795-6fb0585adc72');

  function verify_webhook($data, $hmac_header) {
    $calculated_hmac = base64_encode(hash_hmac('sha256', $data, APP_CODE, true));
    return ($hmac_header == $calculated_hmac);
  }

  /* 
    I can't access HTTP_X_RTB_CUSTOMER_HMAC_SHA256 with $_SERVER['HTTP_X_RTB_PARTNER_HMAC_SHA256']
    , So I access HTTP_X_RTB_CUSTOMER_HMAC_SHA256 with getallheaders instead.
  */
  $hmac_header = getallheaders()['HTTP_X_RTB_CUSTOMER_HMAC_SHA256'];
  $data = file_get_contents('php://input');
  $verified = verify_webhook($data, $hmac_header);

  error_log('Webhook verified: '. var_export($verified, true)); // I get false verfified.
?>
