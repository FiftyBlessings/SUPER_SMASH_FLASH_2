
import Foundation
import SpriteKit
var player = SKSpriteNode.self()
var playerWalkingFrames: [SKTexture] = []

extension SKSpriteNode {
    

    func buildplayer(Atlas: String) {
    let playerAnimatedAtlas = SKTextureAtlas(named: Atlas)
    var walkFrames: [SKTexture] = []
    
    let numImages = playerAnimatedAtlas.textureNames.count
    for i in 1...numImages {
        let playerTextureName = "\(Atlas)\(i)"
        walkFrames.append(playerAnimatedAtlas.textureNamed(playerTextureName))
    }
    playerWalkingFrames = walkFrames
    let firstFrameTexture = playerWalkingFrames[0]
    player = SKSpriteNode(texture: firstFrameTexture)
}
    
func animateplayer() {
    player.run(SKAction.repeatForever(
        SKAction.animate(with: playerWalkingFrames,
                         timePerFrame: 0.1,
                         resize: false,
                         restore: true)),
               withKey:"walkingInPlaceplayer")
}
    
}
