import SpriteKit

class CoinNode: SKSpriteNode {
    let _width = 20
    let _height = 20
    
    class func makeCoin(gold : Int) -> CoinNode {
        let node : CoinNode = CoinNode(imageNamed: "coin")
        node.name = "coin"
        node.userData = ["gold" : gold]
        node.zPosition = 999
        node.setPhysic()
        return node
    }

    // 物理を適用
    func setPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(CGFloat(_width), CGFloat(_height)))
        physic.affectedByGravity = true
        physic.allowsRotation = false
        physic.categoryBitMask = coinCategory
        physic.contactTestBitMask = horizonWorldCategory
        physic.collisionBitMask = worldCategory | wallCategory | downWorldCategory | horizonWorldCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.restitution = 0.8
        
        let rnd = CommonUtil.rnd(2)
        if rnd == 0 {
            physic.velocity = CGVectorMake(CGFloat(CommonUtil.rnd(20)), 200)
        } else {
            physic.velocity = CGVectorMake(CGFloat(-1*CommonUtil.rnd(20)), 200)
        }
        
        self.physicsBody = physic
    }
}