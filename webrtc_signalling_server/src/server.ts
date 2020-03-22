let http = require('http');
let https = require('https');
let WebSocketServer = require('websocket').server;

// @author Cathal Butler - 19/03/2020
/*
 * https://docs.w3cub.com/dom/webrtc_api/signaling_and_video_calling/
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
        if (connectionArray[i].data.to === target) {
            console.log("SEND TO PEER ID " + connectionArray[i].data.to);
            connectionArray[i].sendUTF(request);
            break;
        }
    }
}

/**
 * Function returns a connection by its id from the array
 * of connections
 * @param id, connection id
 */
function getConnectionForID(id) {
    let connect = null;
    for (let i = 0; i < connectionArray.length; i++) {
        if (connectionArray[i].id === id) {
            connect = connectionArray[i];
            break;
        }
    }
    return connect;
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
        console.log(connectionArray[i].data.id);
        peer['name'] = connectionArray[i].data.name;
        console.log(connectionArray[i].data.name);
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

    let requestMessage = {
        type: 'type',
        data: 'data'
        // id: 'id',
        // name: 'name',
        // user_agent: 'user_agent',
    };

    //Send back a message to the client
    //connection.sendUTF(JSON.stringify(requestMessage));

    // Set up a handler for the "message" event received over WebSocket. This
    // is a message sent by a client.
    connection.on('message', function (message) {
        console.log(message.toString());
        if (message.type === 'utf8') {
            log("Received Message: " + message.utf8Data);
            // Process incoming data
            //   let sendToClients = true;
            //Request type & data:
            requestMessage = JSON.parse(message.utf8Data);
            // Add new connection the array on connections (Peers)
            connectionArray.push(connection);
            // Add data to connection
            connection.data = requestMessage.data;
            // Get connection by ID
            let connect = getConnectionForID(requestMessage.data.id);

            //TODO - Complete this
            //Handle incoming request by there type
            switch (requestMessage.type) {
                case 'new':
                    // Send peers to all connected
                    console.log('inside new');
                    sendPeerListToAll();
                    break;
                case 'offer': //Fallthrough
                case 'answer': //Fallthrough
                case 'candidate': //Fallthrough
                    // handle if a user goes away, the return message to the peer trying to start the call
                    //TODO - CB Handle this case, important for finalising connection to candidate
                    console.log('Inside candidate');
                    // Convert to an object to send:
                    let msgString = JSON.stringify(requestMessage);
                    console.log(msgString);

                    // Check that a id exists in the request sent from a client:
                    if (requestMessage.data.to.length && requestMessage.data.to.length !== 0) {
                        // Send on the request to that peer
                        console.log(requestMessage.data.to);
                        console.log(msgString);
                        sendToPeer(requestMessage.data.to, msgString);
                    } else {
                        //Return an error if no ID is found
                        log('No to id found in request message');
                        let errorMessage = {
                            type: 'error',
                            reason: 'Peer to id not found'
                        };
                        let response = JSON.stringify(errorMessage);
                        //Return all connections
                        connect.sendUTF(response);
                    }
                    break;
                case 'leave':
                    // Update when a user leave s call
                    break;
                case 'bye':
                    //Disconnect from server
                    break;
            }//End switch
        }
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