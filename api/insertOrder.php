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
		
		$refWash = $_GET['refWash'];
		$customerId = $_GET['customerId'];
		$dateStart = $_GET['dateStart'];
		$timeStart = $_GET['timeStart'];
		$dateEnd = $_GET['dateEnd'];
		$timeEnd = $_GET['timeEnd'];
		$dry = $_GET['dry'];
		$amountCloth = $_GET['amountCloth'];
		$detergen = $_GET['detergen'];
		$softener = $_GET['softener'];
		$total = $_GET['total'];
		$status = $_GET['status'];
		
		
		
							
		$sql = "INSERT INTO `few_wash`(`id`, `refWash`, `customerId`, `dateStart`, `timeStart`, `dateEnd`, `timeEnd`, `dry`, `amountCloth`, `detergen`, `softener`, `total`, `status`, `idAdminReceive`, `idAdminOrder`) VALUES (Null,'$refWash','$customerId','$dateStart','$timeStart','$dateEnd','$timeEnd','$dry','$amountCloth','$detergen','$softener','$total','$status', '', '' )";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome few1";
   
}
	mysqli_close($link);
?>