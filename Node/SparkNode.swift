import SpriteKit

class SparkNode: SKSpriteNode {
    
    class func makeSpark() {
        var node : SparkNode = CoinNode(imageNamed: "coin")
        node.name = "coin"
        //                node.name = "coin2222"
        node.userData = ["gold" : gold]
        //        node.zPosition = 997
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
        physic.collisionBitMask = worldCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.velocity = CGVectorMake(0, 200)
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