

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
            case "NONE":
                self.Direction = "NONE"
            case "RIGHT":
                self.Direction = "RIGHT"
            case "LEFT":
                self.Direction = "LEFT"
                
            default:
                print ("F U C K T H I S SHOULDNT HAPPEN")
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }
    
}
