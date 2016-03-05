<?php
/**
 * Created by PhpStorm.
 * User: rkrish
 * Date: 2/28/16
 * Time: 2:42 PM
 */
require 'CreateUser.php';

function login($db, $username, $id)
{
    // check to see if the user already exists
    $queryString = "SELECT * FROM users WHERE `id` = .$id.";
    $q = $db->prepare($queryString);
    $q->execute();
    $result = $q->fetch();

    // if the user exists, we're gucci
    if($result)
    {
        return 200;
    }
    // if not, create the user
    else
    {
        try {
            createUser($db, $username, $id);
        }catch(Exception $e) {
            echo "it's not lit";
            return 500;
        }
    }
    return 200;
}