<?php
/**
 * Created by PhpStorm.
 * User: rkrish
 * Date: 2/25/16
 * Time: 12:10 AM
 */

function createUser($db, $username, $id)
{
    $queryString = "INSERT INTO users (.$id., .$username.)";
    $q = $db->prepare($queryString);
    $q->execute(array(':id' => $id));
    $result = $q->fetch();
    return true;
}
?>