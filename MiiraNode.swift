import SpriteKit

class MiiraNode: SKSpriteNode {
    
    let width = 32
    let height = 32
    let half_height = 16
    
    class func makeEnemy(danjon_type : String) -> MiiraNode {
        let enemy : MiiraNode = MiiraNode(imageNamed: "miira_32_32")
        let value : Int
        if danjon_type == "hard" {
            value = 2
        } else if danjon_type == "special" {
            value = 3
        } else {
            value = 1
        }
        enemy.userData =
            [
                "hp" : 5*value,
                "str" : 4,
                "def": 30,
                "gold": 7,
                "name" : "ミイラ娘"
        ]
        enemy.name = "enemy"
        enemy.zPosition = 999
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
        physic.velocity = CGVectorMake(-30, -30)
        self.physicsBody = physic
        
        self.physicsBody = physic
    }
    
    // タイトルでただいるだけ
    class func makeDemo()-> SisterNode {
        let enemy = SisterNode(imageNamed: "sister_32_32")
        enemy.zPosition = 999
        return enemy
    }
}
