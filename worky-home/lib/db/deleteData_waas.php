<?php
require('connection.php');
if($connect === false){
    die("ERROR: Could not connect. " . mysqli_connect_error());
}

$id = $_POST['id'];
echo $id;
$sql = "DELETE FROM `user` WHERE id='$id'";
$connect->query($sql);

if(mysqli_query($connect, $sql)){
    echo "Records Deleted successfully.";
} else{
    echo "ERROR: Could not able to execute $sql. " . mysqli_error($connect);
}
?>