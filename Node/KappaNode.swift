import SpriteKit

class KappaNode: SKSpriteNode {    
    class func makeKappa() -> KappaNode {
        let kappa : KappaNode = KappaNode(imageNamed: "kappa_32_32")
        kappa.name = "kappa"
        return kappa
    }

    // 物理を適用
    func setPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(32,32))
        physic.affectedByGravity = true
        physic.allowsRotation = false
        physic.categoryBitMask = heroCategory
        physic.contactTestBitMask = goalCategory | coinCategory | worldCategory | wallCategory | enemyCategory | itemCategory | blockCategory
        physic.collisionBitMask = worldCategory | wallCategory | horizonWorldCategory | downWorldCategory
        physic.linearDamping = 0
        physic.friction = 0
        self.physicsBody = physic
    }
    
    
    class func makeBigKappa() -> KappaNode {
        let kappa : KappaNode = KappaNode(imageNamed: "kappa_64_64")
        kappa.name = "kappa"
        return kappa
    }
    
    // 物理を適用
    func setBigPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(64,64))
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