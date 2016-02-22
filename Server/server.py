from BaseHTTPServer import BaseHTTPRequestHandler
import urlparse

PORT = 6969

class ReqHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        # Parse the request URL.
        parsedObject = urlparse.urlparse(self.path)
        
        # The path will always start with /, so cut that off
        reqType = parsedObject.path[1:]
        print reqType
        
        # Bool for determining whether we should respond to client with success
        responseCode = 0

        # Determine how we handle the request
        if reqType == 'createUser':
            # Call method to handle request
            responseCode = 200
            print 'Created a user!'
        else:
            print 'Could not handle request!'
            responseCode = 400

        self.send_response(responseCode)
        
if __name__ == '__main__':
    from BaseHTTPServer import HTTPServer
    server = HTTPServer(('0.0.0.0', PORT), ReqHandler)
    print 'Listening on port', PORT
    server.serve_forever()
