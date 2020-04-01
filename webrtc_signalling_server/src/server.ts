'use strict';

let http = require('http');
let https = require('https');
let WebSocketServer = require('websocket').server;
let fs = require('fs');
let path = require('path');

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

function checkConnection(id) {
    for (let i = 0; i < connectionArray.length; i++) {
        if (connectionArray[i].id === id) {
            return true;
            ;
        }
    }
    return false;
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
// let httpsServer = http.createServer(function (request, response) {
//     log("Received secure request for " + request.url);
//     response.write("WebSocket Server - Vertex");
//     response.end();
// });

// Load the key and certificate data to be used for our HTTPS/WSS
// server.
//
let httpsOptions = {
    key: fs.readFileSync(path.resolve("ssl/server.key")),
    cert: fs.readFileSync(path.resolve("ssl/server.cert"))
};

let httpsServer = https.createServer(httpsOptions, function (request, response) {
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

    // Connection
    let connection = request.accept();
    // Add the new connection to our list of connections.
    log("Connection accepted from " + connection.remoteAddress + ".");

    // Request message inbound from client
    let requestMsg = {
        type: 'type',
        data: 'data'
    };

    // Set up a handler for the "message" event received over WebSocket. This
    // is a message sent by a client.
    connection.on('message', function (message) {
        if (message.type === 'utf8') {
            log("Received Message: " + message.utf8Data);
            requestMsg = JSON.parse(message.utf8Data);
            //Assign id and data to connection from request
            connection.id = requestMsg.data.id;
            connection.data = requestMsg.data;

            // let connect = getConnectionForID(requestMsg.data.to);
            let msgString = JSON.stringify(requestMsg);

            //Handle incoming request by there type
            switch (requestMsg.type) {
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
                    if (requestMsg.data.to && requestMsg.data.to.length !== 0) {
                        sendToPeer(requestMsg.data.to, msgString);
                    } else {
                        //Return an error if no ID is found
                        log('No to id found in request message');
                        let errorMessage = {
                            type: 'error',
                            data: 'Peer to id not found'
                        };
                        let response = JSON.stringify(errorMessage);
                        //Return error
                        connection.sendUTF(response);
                    }
                    break;
                case 'leave':
                    break;
                case 'bye':
                    //Disconnect from server
                    log('Disconnecting from server');
                    // Return error if no session id is found
                    if (requestMsg.data.session_id && requestMsg.data.session_id.length == 0) {
                        let errorMsg = {
                            type: 'error',
                            data: 'No session id found'
                        };
                        log('No session id found');
                        let response = JSON.stringify(errorMsg);
                        //Return error
                        connection.sendUTF(response);
                        return;
                    }

                    let sessionId = requestMsg.data['session_id'];
                    let ids = {};
                    ids = sessionId.split("-");

                    // Handle error if a users id does not exist in the connections array:
                    if (checkConnection(ids[0]) == null) {
                        let errorMsg = {
                            type: 'error',
                            data: {
                                requestMsg: requestMsg.type,
                                reason: 'Peer ' + ids[0] + ' not found.'
                            },
                        };
                        log('Peer id not found in connections');
                        let response = JSON.stringify(errorMsg);
                        connection.sendUTF(response);
                        return;
                    } else {
                        let bye = {
                            type: 'bye',
                            data: {
                                to: ids[0],
                                session_id: sessionId
                            },
                        };
                        log('Send bye request to ' + ids[0]);
                        let response = JSON.stringify(bye);
                        sendToPeer(ids[0], response)
                    }

                    // handle error is client 2 ids
                    if (checkConnection(ids[1]) == null) {
                        let errorMsg = {
                            type: 'error',
                            data: {
                                requestMsg: requestMsg.type,
                                reason: 'Peer ' + ids[1] + ' not found.'
                            },
                        };
                        log('Peer id not found in connections');
                        let response = JSON.stringify(errorMsg);
                        connection.sendUTF(response);
                        return;
                    } else {
                        let bye = {
                            type: 'bye',
                            data: {
                                to: ids[1],
                                session_id: sessionId
                            },
                        };
                        log('Send bye request to ' + ids[1]);
                        let response = JSON.stringify(bye);
                        sendToPeer(ids[1], response)
                    }
                    break;
                default:
                    let errorMessage = {
                        type: 'error',
                        data: {reason: 'Unable to process request, may not be correct "type"' + requestMsg.type}
                    };
                    let response = JSON.stringify(errorMessage);
                    connection.sendUTF(response)
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