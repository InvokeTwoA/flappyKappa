import SpriteKit

class FighterNode: SKSpriteNode {
    
    let width = 32
    let height = 32
    let half_height = 16
    
    class func makeEnemy(danjon_type : String) -> FighterNode {
        let enemy : FighterNode = FighterNode(imageNamed: "g_fighter")
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
                "hp" : 8*value,
                "str" : 3,
                "def": 2,
                "gold": 4,
                "name" : "女戦士"
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
        physic.collisionBitMask = worldCategory | downWorldCategory
        physic.linearDamping = 0
        physic.friction = 0
        
        self.physicsBody = physic
    }
    
    // タイトルでただいるだけ
    class func makeDemo()-> FighterNode {
        let enemy = FighterNode(imageNamed: "g_fighter")
        enemy.zPosition = 999
        return enemy
    }
}
