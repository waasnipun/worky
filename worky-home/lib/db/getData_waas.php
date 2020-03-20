<?php
require('connection.php');

$makeQuery = "SELECT * FROM userJobList";

$statement = $connect->query($makeQuery);

$myarray = array();

while($resultFrom = $statement->fetch_assoc()){
    $myarray[] = $resultFrom;

}

echo json_encode($myarray);
?>