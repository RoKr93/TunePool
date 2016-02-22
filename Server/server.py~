from BaseHTTPServer import BaseHTTPRequestHandler
import urlparse

PORT = 6969

class ReqHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        # Parse the request URL.
        parsedObject = urlparse.urlparse(self.path)
        # The path will always start with /student-web/ (which is 12 chars)
        reqType = parsedObject.path[12:]
        # Determine how we handle the request
        if reqType == 'createUser':
            # Do things
            print 'Created a user!'
        else:
            print 'Could not handle request!'

        
if __name__ == '__main__':
    from BaseHTTPServer import HTTPServer
    server = HTTPServer(('localhost', PORT), ReqHandler)
    print 'Listening on port', PORT
    server.serve_forever()
