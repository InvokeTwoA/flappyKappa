import SpriteKit

class AppleNode: SKSpriteNode {
    let _width = 20
    let _height = 20
    
    class func makeApple() -> AppleNode {
        let node : AppleNode = AppleNode(imageNamed: "apple")
        node.name = "apple"
        node.zPosition = 999
        node.setPhysic()
        return node
    }
    func setPhysic(){
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(CGFloat(self._width), CGFloat(self._height)))
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.categoryBitMask = itemCategory
        physic.contactTestBitMask = horizonWorldCategory
        physic.collisionBitMask = worldCategory | downWorldCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.velocity = CGVectorMake(-20, 0)
        self.physicsBody = physic
    }
    
}
