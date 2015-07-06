import SpriteKit

class KappaNode: SKSpriteNode {
    var _lv : Int = 1
    
    class func makeKappa() -> KappaNode {
        var kappa : KappaNode = KappaNode(imageNamed: "kappa_play")
        kappa.name = "kappa"
        return kappa
    }

    // 物理を適用
    func setPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(60,92))
        physic.affectedByGravity = true
        physic.allowsRotation = false
        physic.categoryBitMask = heroCategory
        physic.contactTestBitMask = coinCategory | worldCategory | wallCategory | enemyCategory | itemCategory | blockCategory
        physic.collisionBitMask = worldCategory | wallCategory
        physic.linearDamping = 0
        physic.friction = 0
        self.physicsBody = physic
    }
}