<?php

/*
*	This object will create a new file and put any debug messages/contents into that file
*
*	When an instance of this object is created, a new file is created.
*   Therefore you should only create one debugger for each API call
*
*
*	~Evan Shenkman~
*
*/
class Debugger
{
    //Filepath to the Object Debug output file
    static private $debugFolder = "/vhosts/html/student-web/debug/";

    private $debugFile;

    //Empty constructor
    function __construct()
    {
        //Generate a timestamp for the new debugger file
        $timestamp = new DateTime();

        //String representation of the timestamp object (year-month-day hour:minute:second)
        $this->debugFile = $timestamp->format("m-d H:i:s") . '.txt';
    }

    function __destruct()
    {
        // TODO: Implement __destruct() method.
        $this->cleanUpDebugFolder();
    }

    private function cleanUpDebugFolder()
    {
        //do this some day...
    }

    private function writeDebugMessage($obj, $DBparams = false)
    {
        //Hold the output buffer
        ob_start();

        //Prints the object you want to see inside to the output buffer
        if ($DBparams)
        {
            $obj->debugDumpParams();
        }
        else
        {
            print_r($obj);
        }

        //Get the contents of the output buffer
        $contents = ob_get_contents();

        //Print the contents to the Object Debug text file
        $filePath = self::$debugFolder . $this->debugFile;
        file_put_contents($filePath, $contents, FILE_APPEND);

        //Erase and stop stalling the output buffer
        ob_end_clean();
    }

    //Prints the contents of any object to the Object Debug file
    public function doObjectDebug($obj)
    {
        $this->writeDebugMessage($obj);
    }

    public function doDatabaseErrorDebug($stmt)
    {
        $this->writeDebugMessage($stmt->errorInfo());
    }

    public function doDatabaseQueryDebug($stmt)
    {
        $this->writeDebugMessage($stmt, true);
    }
}

?>