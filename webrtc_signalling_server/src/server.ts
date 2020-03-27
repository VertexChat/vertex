'use strict';

let http = require('http');
let https = require('https');
let WebSocketServer = require('websocket').server;

/*
 * https://docs.w3cub.com/dom/webrtc_api/signaling_and_video_calling/
 * https://www.tutorialspoint.com/webrtc/webrtc_signaling.htm
 * https://www.w3.org/TR/webrtc/#offer-answer-options
 * https://codelabs.developers.google.com/codelabs/webrtc-web/#0
 * https://testrtc.com/webrtc-api-trace/ : DEBUGGER
*/

let connectionArray = [];

// Output logging information to console
function log(text) {
    let time = new Date();
    console.log("[" + time.toLocaleTimeString() + "] " + text);
}

// If you want to implement support for blocking specific origins, this is
// where you do it. Just return false to refuse WebSocket connections given
// the specified origin.
function originIsAllowed(origin) {
    return true; // We will accept all connections
}


/** Sends a message (which is already stringified JSON) to a single
 *  user(peer), this is used when a peer tries to connect to a candidate
 *  @param target, the id of the user the request is being sent too.
 *  @param request, the request data sent from the peer that wants to connect
 */
function sendToPeer(target, request) {
    for (let i = 0; i < connectionArray.length; i++) {
        if (connectionArray[i].id === target) {
            console.log("REMOTE ADDRESS WHEN SENDING TO PEER" + connectionArray[i].remoteAddress);
            connectionArray[i].sendUTF(request);
            break;
        }
    }
}

/**
 * Builds a message object of type "peers" which contains details of users connected to the server
 */
function buildPeerList() {
    let peersResponse = {
        type: "peers",
        data: []
    };
    // Add the users to the list
    for (let i = 0; i < connectionArray.length; i++) {
        let peer = {};
        peer['id'] = connectionArray[i].data.id;
        peer['name'] = connectionArray[i].data.name;
        peer['user_agent'] = connectionArray[i].data.user_agent;
        peersResponse.data.push(peer); // Add a peer to data array of peers
    }
    return peersResponse;
}

/**
 * Sends a "peerList" to all members on the server
 * TODO: CB - This could be done better.
 */
function sendPeerListToAll() {
    let peers = buildPeerList();
    let peersListResponse = JSON.stringify(peers);
    for (let i = 0; i < connectionArray.length; i++) {
        connectionArray[i].sendUTF(peersListResponse);
    }
}

/**
 * HTTP Server, this server just display a message. It is used with a WebSocket for WebRTC
 * @param request, incoming requests
 * @param response, response message
 */
let httpsServer = http.createServer(function (request, response) {
    log("Received secure request for " + request.url);
    response.write("WebSocket Server - Vertex");
    response.end();
});

/**
 * Spin up the HTTPS server on the port 8086
 */
httpsServer.listen(8086, function () {
    log("Server is listening on port 8086");
});


/**
 * Create the WebSocket server by converting the HTTPS server into one.
 */
let wsServer = new WebSocketServer({
    httpServer: httpsServer,
    autoAcceptConnections: false,
    //TODO - CB: This may need to be updated to work with some other querying connections
    path: '/ws',//Path to access ws
});

// Set up a "connect" message handler on our WebSocket server. This is
// called whenever a user connects to the server's port using the
// WebSocket protocol.
wsServer.on('request', function (request) {
    if (!originIsAllowed(request.origin)) {
        request.reject();
        log("Connection from " + request.origin + " rejected.");
        return;
    }

    let connection = request.accept('json', request.origin);
    // Add the new connection to our list of connections.
    log("Connection accepted from " + connection.remoteAddress + ".");

    // Request message inbound from client
    let requestMessage = {
        type: 'type',
        data: 'data'
    };

    //Send back a message to the client
    //connection.sendUTF(JSON.stringify(requestMessage));

    // Set up a handler for the "message" event received over WebSocket. This
    // is a message sent by a client.
    connection.on('message', function (message) {
        if (message.type === 'utf8') {
            log("Received Message: " + message.utf8Data);
            requestMessage = JSON.parse(message.utf8Data);
            //Assign id and data to connection from request
            connection.id = requestMessage.data.id;
            connection.data = requestMessage.data;

            // let connect = getConnectionForID(requestMessage.data.to);
            let msgString = JSON.stringify(requestMessage);

            //TODO - Complete this
            //Handle incoming request by there type
            switch (requestMessage.type) {
                case 'new':
                    // Send peers to all connected
                    connectionArray.push(connection);
                    // Add data to current connection
                    // Add new connection the array on connections (Peers)
                    sendPeerListToAll();
                    break;
                case 'offer': //Fallthrough
                case 'answer': //Fallthrough
                case 'candidate': //Fallthrough
                    // Convert to an object to send:
                    // Check that a id exists in the request sent from a client:
                    if (requestMessage.data.to && requestMessage.data.to.length !== 0) {
                        sendToPeer(requestMessage.data.to, msgString);
                    } else {
                        //Return an error if no ID is found
                        log('No to id found in request message');
                        let errorMessage = {
                            type: 'error',
                            reason: 'Peer to id not found'
                        };
                        let response = JSON.stringify(errorMessage);
                        //Return error
                        connection.sendUTF(response);
                    }
                    break;
                case 'leave':
                    // Update when a user leaves a call
                    //TODO - CB
                    break;
                case 'bye':
                    //Disconnect from server
                    //TODO - CB
                    break;
            }//End switch
        }//End if
    });

    // Handle the WebSocket "close" event; this means a user has logged off
    // or has been disconnected.
    connection.on('close', function (reason, description) {
        // First, remove the connection from the list of connections.
        connectionArray = connectionArray.filter(function (el, idx, ar) {
            return el.connected;
        });
        // Now send the updated user list to clients
        sendPeerListToAll();
        // Build and output log output for close information.
        let logMessage = "Connection closed: " + connection.remoteAddress + " (" +
            reason;
        if (description !== null && description.length !== 0) {
            logMessage += ": " + description;
        }
        logMessage += ")";
        log(logMessage);
    });
});