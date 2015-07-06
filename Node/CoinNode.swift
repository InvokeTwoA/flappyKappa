import SpriteKit

class CoinNode: SKSpriteNode {
    let _width = 20
    let _height = 20
    
    class func makeCoin(gold : Int) -> CoinNode {
        var node : CoinNode = CoinNode(imageNamed: "coin")
        node.name = "coin"
        node.userData = ["gold" : gold]
        node.zPosition = 800
        node.setPhysic()
        return node
    }
    
    func setPhysic(){
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(CGFloat(self._width), CGFloat(self._height)))
        physic.affectedByGravity = true
//        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.categoryBitMask = coinCategory
        physic.collisionBitMask = 0
        physic.linearDamping = 0
        physic.friction = 0
        physic.velocity = CGVectorMake(0, 200)
//        physic.applyImpulse(CGVectorMake(70, 200))
        self.physicsBody = physic
    }

    /*
    func setPhysic(){
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(CGFloat(self._width), CGFloat(self._height)))
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.categoryBitMask = blockCategory
        physic.collisionBitMask = 0
        physic.linearDamping = 0
        physic.friction = 0
        physic.velocity = CGVectorMake(-20, 0)
        self.physicsBody = physic
    }
*/
    
}