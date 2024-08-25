<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$OrderId = $_GET['OrderId'];
		$ServiceId = $_GET['ServiceId'];
		$Price = $_GET['Price'];
		$Amount = $_GET['Amount'];
		$TimeDelivery = $_GET['TimeDelivery'];
		$Date = $_GET['Date'];
		
		
							
		$sql = "INSERT INTO `few_chooseproduct`(`OrderId`, `ServiceId`, `Price`, `Amount`, `TimeDelivery`, `Date`, `Status`) VALUES (Null,'$OrderId','$ServiceId','$Price','$Amount','$TimeDelivery','$Date','$user')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome few ChooserProduct222";
   
}
	mysqli_close($link);
?>