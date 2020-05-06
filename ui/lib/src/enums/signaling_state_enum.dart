/// Enum for different states
enum SignalingState {
  CallStateNew, // New call
  CallStateRinging, // Ringing
  CallStateInvite, //Invite to call
  CallStateConnected, // Connected to call
  CallStateBye, // End call 'bye'
  ConnectionOpen, // Open call
  ConnectionClosed, // Connection closed
  ConnectionError, // Connection error
  ConnectionConnecting, // Connecting state
  FetchingData,
  ReceivedData
}