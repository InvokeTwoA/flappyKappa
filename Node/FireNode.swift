import SpriteKit

class FireNode: SKEmitterNode {
    
    class func make(location : CGPoint) -> SKEmitterNode {
        let path = NSBundle.mainBundle().pathForResource("fire", ofType: "sks")
        let particle = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        particle.position = CGPointMake(location.x + 0.0, location.y)

        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(50.0, 50.0))
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.categoryBitMask = fireCategory
        physic.contactTestBitMask = enemyCategory
        physic.collisionBitMask = 0
        particle.physicsBody = physic
        particle.zPosition = 999
        particle.name = "fire"
        return particle
    }

}
