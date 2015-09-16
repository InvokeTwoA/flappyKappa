import SpriteKit

class KappaNode: SKSpriteNode {    
    class func makeKappa() -> KappaNode {
//        var kappa : KappaNode = KappaNode(imageNamed: "kappa_play")
        var kappa : KappaNode = KappaNode(imageNamed: "kappa_76_88")
        kappa.name = "kappa"
        return kappa
    }

    // 物理を適用
    func setPhysic() {
//        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(60,92))
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(46,88))
        physic.affectedByGravity = true
        physic.allowsRotation = false
        physic.categoryBitMask = heroCategory
        physic.contactTestBitMask = goalCategory | coinCategory | worldCategory | wallCategory | enemyCategory | itemCategory | blockCategory
        physic.collisionBitMask = worldCategory | wallCategory | horizonWorldCategory | downWorldCategory
        physic.linearDamping = 0
        physic.friction = 0
        self.physicsBody = physic
    }
}