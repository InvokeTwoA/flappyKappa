import SpriteKit

class BigCatNode: SKSpriteNode {
    var lv : Int = 1
    let width = 205
    let height = 190
    let half_height :Int = 100

    class func makeEnemy() -> BigCatNode {
        var enemy : BigCatNode = BigCatNode(imageNamed: "bigCat")
        enemy.zPosition = 999
        enemy.userData =
            [
                "hp" : 40,
                "str" : 3,
                "def": 20,
                "mdef": 10,
                "gold": 500,
                "score": 10
            ]
        enemy.name = "boss"
        enemy.setPhysic()
        return enemy
    }
    
    // 物理を適用
    func setPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(CGFloat(width), CGFloat(height)))
        physic.affectedByGravity = true
        physic.allowsRotation = false
        physic.categoryBitMask = enemyCategory
        physic.contactTestBitMask = fireCategory | swordCategory | worldCategory
        physic.collisionBitMask = worldCategory | wallCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.restitution = 1.0
        physic.velocity = CGVectorMake(-1, 0)
        self.physicsBody = physic
    }
}
