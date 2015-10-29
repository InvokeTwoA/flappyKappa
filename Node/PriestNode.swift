import SpriteKit

class PriestNode: SKSpriteNode {
    let width = 32
    let height = 32
    let half_height :Int = 16
    
    class func makeEnemy(danjon_type: String) -> PriestNode {
        let enemy : PriestNode = PriestNode(imageNamed: "sister_64_64")
        enemy.zPosition = 999
        var value : Int = 1
        if danjon_type == "hard" {
            value = 3
        } else if danjon_type == "special" {
            value = 2
        }
        enemy.userData =
            [
                "hp" : 10*value,
                "str" : 6,
                "def": 6,
                "mdef": 50,
                "gold": 40,
                "score": 500,
                "name": "骸骨巨人"
        ]
        enemy.name = "boss"
        enemy.setPhysic()
        return enemy
    }
    
    // 物理を適用
    func setPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(CGFloat(width), CGFloat(height)))
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.categoryBitMask = enemyCategory
        physic.contactTestBitMask = fireCategory | swordCategory | worldCategory
        physic.collisionBitMask = worldCategory | wallCategory | downWorldCategory | horizonWorldCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.restitution = 1.0
        physic.velocity = CGVectorMake(-70, -70)
        self.physicsBody = physic
    }
}
