import SpriteKit

class BeerNode: SKSpriteNode {
    let width = 45
    let height = 46
    let half_height :Int = 23
    
    class func makeEnemy() -> BeerNode {
        var enemy : BeerNode = BeerNode(imageNamed: "beer")
        enemy.zPosition = 999
        enemy.name = "boss"
        enemy.setPhysic()
        return enemy
    }
    
    // 物理を適用
    func setPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(CGFloat(width), CGFloat(height)))
        physic.affectedByGravity = true
        physic.allowsRotation = false
        physic.categoryBitMask = goalCategory
        physic.contactTestBitMask = 0
        physic.collisionBitMask = worldCategory | wallCategory | downWorldCategory | horizonWorldCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.restitution = 0.0
        self.physicsBody = physic
    }
}
