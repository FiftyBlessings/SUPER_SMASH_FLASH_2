import Foundation
import MultipeerConnectivity

protocol ColorServiceDelegate {
    
    func connectedDevicesChanged(manager : ColorService, connectedDevices: [String])
    func colorChanged(manager : ColorService, colorString: String)
    
}
//The MCNearbyServiceAdvertiser class publishes an advertisement for a specific service that your app provides through the Multipeer Connectivity framework and notifies its delegate about invitations from nearby peers
class ColorService : NSObject {
    
/* Service type must be a unique string, at most 15 characters long and can contain only ASCII lowercase letters, numbers and hyphens. The serviceType parameter is a short text string used to describe the app's networking protocol */
    private let ColorServiceType = "Smash"
    //This line makes the persons "username" the name of the device they are using
    private let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    //The MCNearbyServiceAdvertiser class publishes an advertisement for a specific service that your app provides through the Multipeer Connectivity framework and notifies its delegate about invitations from nearby peers
    private let serviceAdvertiser : MCNearbyServiceAdvertiser
    private let serviceBrowser : MCNearbyServiceBrowser
    // The delegate object that handles advertising-related events
    var delegate : ColorServiceDelegate?
    
    lazy var session : MCSession = {
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        return session
    }()
    
    override init() {
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: ColorServiceType)
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: ColorServiceType)
        
        super.init()
        // Begins advertising the service provided by a local peer
        self.serviceAdvertiser.delegate = self
        self.serviceAdvertiser.startAdvertisingPeer()
        // Begins advertising the browser provided by a local peer
        self.serviceBrowser.delegate = self
        self.serviceBrowser.startBrowsingForPeers()
    }
    
    deinit {
        // Stops advertising the service provided by a local peer and the browser for local peers
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.stopBrowsingForPeers()
    }
    
    func send(colorName : String) {
        NSLog("%@", "sendColor: \(colorName) to \(session.connectedPeers.count) peers")
        
        if session.connectedPeers.count > 0 {
            do {
                try self.session.send(colorName.data(using: .utf8)!, toPeers: session.connectedPeers, with: .reliable)
            }
            catch let error {
                NSLog("%@", "Error for sending: \(error)")
            }
        }
        
    }
    
}

extension ColorService : MCNearbyServiceAdvertiserDelegate {
    // This is called when the advertisement fails which in this case will print to the log "didNotStartAdvertisingPeer: \(error)" which is the error code provided by xocde. Advertiser: The advertiser object that failed to begin advertising. Error: An error object that indicates what went wrong.
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
    }
    // Called when an invatation to join a session is received from a nearby peer. Advertiser: The advertiser object that was invited to join the session. PeerID: The peer ID of the nearby peer that invited your app to join the session. Context: An arbitrary piece of data received from the nearby peer. This can be used to provide further information to the user about the nature of the invitation. InvitationHandler: A block that your code must call to indicate whether the advertiser should accept or decline the invitation, and to provide a session with which to associate the peer that sent the invitation.
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        NSLog("%@", "didReceiveInvitationFromPeer \(peerID)")
        invitationHandler(true, self.session)
    }
    
}

extension ColorService : MCNearbyServiceBrowserDelegate {
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        NSLog("%@", "didNotStartBrowsingForPeers: \(error)")
    }
    /* The Discovery info here is a dictonary that will display the a string as the info */
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        NSLog("%@", "foundPeer: \(peerID)")
        NSLog("%@", "invitePeer: \(peerID)")
        browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 10)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        NSLog("%@", "lostPeer: \(peerID)")
    }
    
}

extension ColorService : MCSessionDelegate {
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        NSLog("%@", "peer \(peerID) didChangeState: \(state.rawValue)")
        self.delegate?.connectedDevicesChanged(manager: self, connectedDevices:
            session.connectedPeers.map{$0.displayName})
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveData: \(data)")
        let str = String(data: data, encoding: .utf8)!
        self.delegate?.colorChanged(manager: self, colorString: str)
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveStream")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        NSLog("%@", "didStartReceivingResourceWithName")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        NSLog("%@", "didFinishReceivingResourceWithName")
    }
    
}
