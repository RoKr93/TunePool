<?php

/*
*	Logger will handle all messages that need to be stored in a text log.
*
*	These logs should be used extremely liberally and should function as the first step in finding errors within programs.
*
*	These logs should not be used to actively debug, but should provide a hint as to where you should begin the debugging process.
*	For Debugging, use Debugger.php
*
*	Logs can be found in this location: /var/www/.logs/
*
*	There are three different types of Logs
*
*		1. System Log
*			General system status messages
*
*		2. Error Log
*			Anytime an error is caught, detailed messages of the error should be logged here.
*
*		3. Database Error Log
*			Errors specific to Database functionality should be logged here.
*
*
*	~Evan Shenkman~
*
*/
class Logger
{
    //Filepath to the System Log text file
    static private $systemLog = "/vhosts/html/student-web/logs/";

    //Filepath to the Error Log text file
    static private $errorLog = "/vhosts/html/student-web/logs/";

    //Empty constructor
    function __construct()
    {

    }

    //Destructor
    function __destruct()
    {
        //Whenever a Logger is destroyed, see if we need to archive any of the log files.
        $this->archiveLogs();
    }

    //Writes a message to the general System Log
    public function writeToSystemLog($msg, $script, $lineNum = NULL)
    {
        $logMessage = $this->formatMessage($msg, $script, $lineNum);
        file_put_contents(self::$systemLog, $logMessage, FILE_APPEND);
    }

    //Writes a message to the general Error Log
    public function writeToErrorLog($msg, $script, $lineNum = NULL)
    {
        $logMessage = $this->formatMessage($msg, $script, $lineNum);
        file_put_contents(self::$errorLog, $logMessage, FILE_APPEND);
    }

    //Creates a formatted string that will be appended to a log file
    //
    //Format:
    //	Script Name - Line # the log function was called from: The message to be logged -- timestamp
    private function formatMessage($msg, $script, $lineNum = NULL)
    {
        //Generate a timestamp for the log message
        $timestamp = new DateTime();

        //String representation of the timestamp object (year-month-day hour:minute:second)
        $stringTimestamp = $timestamp->format("Y-m-d H:i:s");

        //Format the log message...
        $logMessage = $script . ": " . $msg . " -- " . $stringTimestamp;

        //If there's a line Number, add that to the formatted log message
        if ($lineNum)
        {
            $logMessage = $script . " - Line # " . $lineNum .": " . $msg . " -- " . $stringTimestamp;
        }

        //Return the log message, including a newline character
        return trim($logMessage)."\n";
    }

    //Function to see if any log files should be archived
    private function archiveLogs()
    {
        //Generate a new timestamp
        $timestamp = new DateTime();

        //String representation of the timestamp object (month.day.year - hour:minute)
        $today = $timestamp->format("m.d.y-H:i");

        //Check the size of the System Log file
        $linecount = 0;

        //Open a file handle - readonly
        $handle = fopen(self::$systemLog, "r");

        if($handle)
        {
            //Read the file all the way until the end
            while(!feof($handle))
            {
                //Read a portion in at a time
                $line = fgets($handle, 4096);

                //Increase the linecount for each newline character found
                $linecount += substr_count($line, "\n");
            }

            //Close the file handle
            fclose($handle);

            //If the line count exceeds 300, let's archive the log
            if ($linecount >= 300)
            {
                //New file name = system_log_7.7.15-13:20.txt
                $newName = "/vhosts/html/student-web/logs/system_log_archives/sys_log_" . $today . ".txt";

                //Rename the current log file to the new file name
                rename(self::$systemLog, $newName);
            }
        }

        //Check the size of the Error Log file
        $linecount = 0;

        $handle = fopen(self::$errorLog, "r");

        if($handle)
        {
            while(!feof($handle))
            {
                $line = fgets($handle, 4096);
                $linecount += substr_count($line, "\n");
            }

            if ($linecount >= 300)
            {
                $newName = "/vhosts/html/student-web/logs/error_log_archives/err_log_" . $today . ".txt";
                rename(self::$errorLog, $newName);
            }

            fclose($handle);
        }
    }
}

?>