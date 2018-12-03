
import Foundation
import SpriteKit

var playerWalkingFrames: [SKTexture] = []
extension SKSpriteNode {
    


    func buildplayer(Atlas: String) {
    let playerAnimatedAtlas = SKTextureAtlas(named: Atlas)
    var walkFrames: [SKTexture] = []
    
    let numImages = playerAnimatedAtlas.textureNames.count
    for i in 1...numImages {
        let playerTextureName = ("\(Atlas)\(i)")
        walkFrames.append(playerAnimatedAtlas.textureNamed(playerTextureName))
    }
    playerWalkingFrames = walkFrames
    let firstFrameTexture = playerWalkingFrames[0]
    self.texture = firstFrameTexture
}
    
func animateplayer() {
    self.run(SKAction.repeatForever(
        SKAction.animate(with: playerWalkingFrames,
                         timePerFrame: 0.1,
                         resize: false,
                         restore: true)),
               withKey:"walkingInPlaceplayer")
}
    func StrafeLeft() {
        buildplayer(Atlas: "L_LLOYD_WALK")
        animateplayer()
    }
    
    func StrafeRight() {
        buildplayer(Atlas: "R_LLOYD_WALK")
        animateplayer()
    }
    
    func Jump() {
        buildplayer(Atlas: "LLOYD_WALK")
        animateplayer()
    }
    
    func Duck() {
        buildplayer(Atlas: "LLOYD_WALK")
        animateplayer()
    }
    
    func IdleLeft() {
        buildplayer(Atlas: "L_LLOYD_IDLE")
        animateplayer()
    }
    
    func IdleRight() {
        buildplayer(Atlas: "R_LLOYD_IDLE")
        animateplayer()
    }
}
