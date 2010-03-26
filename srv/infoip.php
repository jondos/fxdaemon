<?
//echo "IP=". $_SERVER['REMOTE_ADDR'].";";
//echo "Port=". $_SERVER['REMOTE_PORT'].";";
//echo "Method=". $_SERVER['REQUEST_METHOD'].";";
$resStr = "IP=". $_SERVER['REMOTE_ADDR'].";"."Method=". $_SERVER['REQUEST_METHOD'].";";
//$resStr =. "Accept=". $_SERVER['HTTP_ACCEPT'].";";
echo base64_encode($resStr);
?>
