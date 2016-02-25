<?php
	// ini_set('memory_limit', '-1');
	
	//require 'PHPMailer/PHPMailerAutoload.php';

	// Helper method to get a string description for an HTTP status code
    // From http://www.gen-x-design.com/archives/create-a-rest-api-with-php/
	function getStatusCodeMessage($status)
    {
        // these could be stored in a .ini file and loaded
        // via parse_ini_file()... however, this will suffice
        // for an example
        $codes = Array(
                       100 => 'Continue',
                       101 => 'Switching Protocols',
                       200 => 'OK',
                       201 => 'Created',
                       202 => 'Accepted',
                       203 => 'Non-Authoritative Information',
                       204 => 'No Content',
                       205 => 'Reset Content',
                       206 => 'Partial Content',
                       300 => 'Multiple Choices',
                       301 => 'Moved Permanently',
                       302 => 'Found',
                       303 => 'See Other',
                       304 => 'Not Modified',
                       305 => 'Use Proxy',
                       306 => '(Unused)',
                       307 => 'Temporary Redirect',
                       400 => 'Bad Request',
                       401 => 'Unauthorized',
                       402 => 'Payment Required',
                       403 => 'Forbidden',
                       404 => 'Not Found',
                       405 => 'Method Not Allowed',
                       406 => 'Not Acceptable',
                       407 => 'Proxy Authentication Required',
                       408 => 'Request Timeout',
                       409 => 'Conflict',
                       410 => 'Gone',
                       411 => 'Length Required',
                       412 => 'Precondition Failed',
                       413 => 'Request Entity Too Large',
                       414 => 'Request-URI Too Long',
                       415 => 'Unsupported Media Type',
                       416 => 'Requested Range Not Satisfiable',
                       417 => 'Expectation Failed',
                       500 => 'Internal Server Error',
                       501 => 'Not Implemented',
                       502 => 'Bad Gateway',
                       503 => 'Service Unavailable',
                       504 => 'Gateway Timeout',
                       505 => 'HTTP Version Not Supported'
                       );
        
        return (isset($codes[$status])) ? $codes[$status] : '';
    }
    
    // Helper method to send a HTTP response code/message
    function sendResponse($status = 200, $body = '', $content_type = 'text/html')
    {
        $status_header = 'HTTP/1.1 ' . $status . ' ' . getStatusCodeMessage($status);
        header($status_header);
        header('Content-type: ' . $content_type);        
        echo $body;
    }
    
    class BaseAPI
    {    
        private $db;
		private $folder;
        
        // Constructor - open DB connection
        function __construct() 
        {
			// $this->folder = "uploading/";
			//Note: Keep the two lines below, and just uncomment the one you want to connect to
			//$this->db = new PDO("pgsql:dbname=meatfest_dev;host=localhost",'evanshenkman','rileyrose');
			// $this->db = new PDO("pgsql:dbname=smartbar_dev;host=localhost",'postgres','628114');
            //var_dump($this->db);
			$this->db = new PDO("pgsql:dbname=student_projects; host=localhost, 'student', I1sAStudent");
        }
        
        // Destructor - close DB connection
        function __destruct() 
        {
            $this->db=null;
        }
        	
		function testConnection()
		{
			//
			//EXPAND THIS TO ALSO CHECK FOR DB CONNECTION?
			//
			
			$result = array("response" => 'success');
			sendResponse(200, json_encode($result));
			return true;
		}
			
		//Main method
		function doWork()
		{
			try
			{
				if(!isset($_POST["operation"]))
				{
					$result = array("response" => 'failure', "error" => 'Invalid request. No operation given.', "POST" => $_POST);
					sendResponse(400, json_encode($result));
					return false;
				}
				
				$op = $_POST["operation"];
		
				//check which method we want to call
				if ($op == "testConnection")
				{
					return $this->testConnection();
				}
				
				$result = array("response" => 'Invalid request. Not a valid operation.');
				sendResponse(200, json_encode($result));
				return false;
			}
			
			catch(Exception $e)
			{
				$error = array("response" => 'failure', "message" => 'Server exception: '.$e->getMessage());
				sendResponse(200, json_encode($error));
				return false;
			}
		}
	}
		
	// This is the first thing that gets called when this page is loaded
	// Creates a new instance of the BaseAPI class and calls the doWork method
	$api = new BaseAPI;
	$api->doWork();
?>