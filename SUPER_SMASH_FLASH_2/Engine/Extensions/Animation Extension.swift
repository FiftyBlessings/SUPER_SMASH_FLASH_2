
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
    
    func animateplayer(_ Repeats: Bool) {
        if Repeats == true {
            self.run(SKAction.repeatForever(
        SKAction.animate(with: playerWalkingFrames,
                         timePerFrame: 0.1,
                         resize: true,
                         restore: true)),
               withKey:"LLOYD")
        } else if Repeats == false {
            self.run(
                SKAction.animate(with: playerWalkingFrames,
                                 timePerFrame: 0.1,
                                 resize: true,
                                 restore: true),
                     withKey:"walkingInPlaceplayer")
        }
}
        func Strafe(_ Direction: String) {
        if Direction == "RIGHT" {
            buildplayer(Atlas: "R_LLOYD_WALK")
            animateplayer(true)
        } else if Direction == "LEFT" {
            buildplayer(Atlas: "L_LLOYD_WALK")
            animateplayer(true)
        }
    }
        func Jump(_ Direction: String) {
        if Direction == "RIGHT" {
            buildplayer(Atlas: "UR_LLOYD_JUMP")
            animateplayer(false)
        } else if Direction == "LEFT" {
            buildplayer(Atlas: "UL_LLOYD_JUMP")
            animateplayer(false)
        }
    }
        func Duck(_ Direction: String) {
        if Direction == "RIGHT" {
            buildplayer(Atlas: "R_LLOYD_DUCK")
            animateplayer(true)
        } else if Direction == "LEFT" {
            buildplayer(Atlas: "L_LLOYD_DUCK")
            animateplayer(true)
            }
    }
    func Idle(_ Direction: String) {
        if Direction == "RIGHT" {
            buildplayer(Atlas: "R_LLOYD_IDLE")
            animateplayer(true)
        } else if Direction == "LEFT" {
            buildplayer(Atlas: "L_LLOYD_IDLE")
            animateplayer(true)
        }
    }
    func Attack(_ Direction: String) {
        if Direction == "RIGHT" {
            buildplayer(Atlas: "R_Lloyd_AttackStanding")
            animateplayer(false)
        } else if Direction == "LEFT" {
            buildplayer(Atlas: "L_Lloyd_AttackStanding")
            animateplayer(false)
        }
    }
    func Fall(_ Direction: String) {
        if Direction == "RIGHT" {
            buildplayer(Atlas: "R_LLOYD_FALLING")
            animateplayer(true)
        } else if Direction == "LEFT" {
            buildplayer(Atlas: "L_LLOYD_FALLING")
            animateplayer(true)
        }
    }
}
