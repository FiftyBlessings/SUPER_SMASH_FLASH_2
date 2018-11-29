

import Foundation
import UIKit

extension GameScene : ColorServiceDelegate {
    
    func connectedDevicesChanged(manager: ColorService, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            
        }
    }
    
    func colorChanged(manager: ColorService, colorString: String) {
        OperationQueue.main.addOperation {
            switch colorString {
            case "true":
                
                self.touch = true
                self.player.StrafeRight()
            case "false":
                self.touch = false
                self.player.IdleRight()
                
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }
    
}
