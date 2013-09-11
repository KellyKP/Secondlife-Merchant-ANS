<?php 

    $con=mysql_connect("localhost", "Username", "Password") or die(mysql_error());
    mysql_select_db("Database",$con) or die(mysql_error());

 	$tTransactionID = $_GET['TransactionID'];
	$Timestamp = gmdate("Y-m-d\TH:i:s\Z",time());
 	$tItemID = $_GET['ItemID'];
 	$tItemName = $_GET['ItemName'];
 	$tMerchantName = $_GET['MerchantName'];	
	$tPayerName = $_GET['PayerName'];
	$tPayerKey = $_GET['PayerKey'];
 	$tReceiverName = $_GET['ReceiverName'];
 	$tReceiverKey = $_GET['ReceiverKey'];
	$tPaymentGross = $_GET['PaymentGross'];
 	$tLocation = $_GET['Location'];
if ($tLocation != 'In-World')
	$tLocation = 'Marketplace';

if ($tPaymentGross != '0')
{   
$sql="INSERT INTO ANS VALUES ('','$Timestamp',
'$tTransactionID',
'$tItemID',
'$tItemName',
'$tMerchantName',
'$tPayerName',
'$tPayerKey',
'$tReceiverName',
'$tReceiverKey',
'$tPaymentGross',
'$tLocation'
)";
$result=mysql_query($sql) or die(mysql_error());
}

mysql_close($con);
?>
