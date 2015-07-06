import SpriteKit

class SwordNode: SKSpriteNode {
    
    class func makeSword() -> SwordNode {
        var node : SwordNode = SwordNode(imageNamed: "sword")
        node.name = "sword"
        node.zPosition = 999

        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(CGFloat(24), CGFloat(24)))
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.categoryBitMask = swordCategory
        physic.contactTestBitMask = blockCategory
        physic.collisionBitMask = worldCategory
        physic.linearDamping = 0
        physic.friction = 0
        node.physicsBody = physic
        return node
    }
}
