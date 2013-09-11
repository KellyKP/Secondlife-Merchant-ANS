<?php
    $con=mysqli_connect("localhost", "Username", "Password") or die(mysql_error());

$result = mysqli_query($con,"SELECT * FROM ANS");

echo "<html><table border='1' width ='95%'><tr><th>ID</th><th>Name</th><th></th><th>Item</th><th>Profit</th><th>Gift?</th><th>Location</th></tr>";

while($row = mysqli_fetch_array($result))
{
$username = $row['PayerName'];
if (strpos($username,' '))
$username = str_replace(" ",".",$username);
if ($row['MerchantName'] == 'Xiant Hax')
$src = '(Creative Dept.)';
else
$src = '(Consumer Dept.)';
$avaimg = '<img src=\'http://my-secondlife.s3.amazonaws.com/users/'.strtolower($username).'/thumb_sl_image.png\' width = \'32px\'>';
if ($row['Location'] == 'Marketplace')
$Profit = round($row[PaymentGross]*((100-5)/100));
else if ($row['Location'] == 'In-World')
$Profit = $row[PaymentGross];
if ($row['ReceiverName'] != $row['PayerName'])
$Gift = 'Yes';
else
$Gift = 'No';
echo "<tr>";
echo "<td>" .$row['ID']. "</td>";
echo "<td><a href = http://my.secondlife.com/$username>$avaimg</a></td>";
echo "<td><a href = http://my.secondlife.com/$username>".$row['PayerName']."</a></td>";
echo "<td>" .$row['ItemName']. "</td>";
echo "<td>$Profit</td>";
echo "<td>$Gift</td>";
echo "<td>" .$row['Location']." ".$src."</td>";
echo "</tr>";
}
echo "</table></html>";

mysqli_close($con);
?>