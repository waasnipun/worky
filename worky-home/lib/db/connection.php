<?php



    try{
        $connect = new mysqli("localhost","id12953224_workydatabase","worky@12345","id12953224_workydatabase");

    }catch(PDOException $exc){
        echo "Connection Failed";
    }

?>