import SpriteKit

class BigSlimeNode: SKSpriteNode {
    var lv : Int = 1
    let width = 128
    let height = 128
    let half_height :Int = 100

    class func makeEnemy(danjon_type : String) -> BigSlimeNode {
        let enemy : BigSlimeNode = BigSlimeNode(imageNamed: "big_slime")
        enemy.zPosition = 999
        var value : Int = 1
        if danjon_type == "hard" {
            value = 2
        } else if danjon_type == "special" {
            value = 3
        }
        enemy.userData =
            [
                "hp" : 35*value,
                "str" : 3,
                "def": 2,
                "mdef": 10,
                "gold": 10,
                "name" : "巨大スライム"
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
        physic.collisionBitMask = worldCategory | wallCategory | downWorldCategory | horizonWorldCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.restitution = 0.95
        physic.velocity = CGVectorMake(-1, 0)
        self.physicsBody = physic
    }
}
