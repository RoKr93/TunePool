<?php

//include('utilityFunctions.php');
include('Debugger.php');

class ResponseManager
{
    private $debugger;

    function __construct($debugger = null)
    {
        $this->debugger = $debugger;
    }

    //Helper function to build the JSON response
    public function buildReturnMessage($msg, $data = NULL, $success = true)
    {
        $code = 400;
        if ($success) $code = 200;
        header('HTTP/1.1 ' . $code);
        header('Content-type: text/html');
        $returnMsg = json_encode(array("success" => $success, "msg" => $msg, "data" => $data));

        if (is_a($this->debugger, Debugger::class))
        {
            $this->debugger->doObjectDebug($returnMsg);
        }

        return $returnMsg;
    }
}

?>