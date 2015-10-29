import SpriteKit

class SlimeNode: SKSpriteNode {
    
    let width = 32
    let height = 32
    let half_height = 16
    
    var _dx :Int = 36

    class func makeEnemy(danjon_type : String) -> SlimeNode {
        let enemy = SlimeAnimateNode()
        
        enemy._dx = 36
        
        var value : Int = 1
        if danjon_type == "hard" {
            value = 3
        } else if danjon_type == "special" {
            value = 2
        }
        enemy.userData =
            [
                "hp" : 3 * value,
                "str" : 1,
                "def": 1,
                "mdef": 0,
                "gold": 1,
                "score": 1,
                "name" : "スライム"
            ]
        enemy.name = "enemy"
        enemy.zPosition = 999
        enemy.setPhysic()
        return enemy
    }
    
    class func makeSuperEnemy(danjon_type: String) -> SlimeNode {
        let enemy : SlimeNode = SlimeNode(imageNamed: "green_slime")
        enemy._dx = 95
        let value : Int
        if danjon_type == "hard" {
            value = 3
        } else if danjon_type == "special" {
            value = 2
        } else {
            value = 1
        }
        enemy.userData =
            [
                "hp" : 6 * value,
                "str" : 5,
                "def": 2,
                "mdef": 0,
                "gold": 10,
                "score": 20,
                "name": "ピーマン"
        ]
        enemy.name = "enemy"
        enemy.zPosition = 999
        enemy.setPhysic()
        return enemy
    }

    class func makeMetalEnemy(danjon_type: String) -> SlimeNode {
        let enemy : SlimeNode = SlimeNode(imageNamed: "metal_slime")
        enemy._dx = 200
        let value : Int
        if danjon_type == "hard" {
            value = 3
        } else if danjon_type == "special" {
            value = 2
        } else {
            value = 1
        }
        enemy.userData =
            [
                "hp" : 2 * value,
                "str" : 1,
                "def": 99,
                "mdef": 0,
                "gold": 1111,
                "score": 20,
                "name": "金の亡者"
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
        physic.allowsRotation = true
        physic.categoryBitMask = enemyCategory
        physic.contactTestBitMask = fireCategory | swordCategory | worldCategory
        physic.collisionBitMask = heroCategory | worldCategory | downWorldCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.velocity = CGVectorMake(CGFloat(-1*_dx), 0)
        self.physicsBody = physic
    }
    
    class func SlimeAnimateNode() -> SlimeNode {
        let s1 : SKTexture = SKTexture(imageNamed: "slime1")
        let s2 : SKTexture = SKTexture(imageNamed: "slime2")
        let action = SKAction.animateWithTextures([s1, s2], timePerFrame: 1.00)
        let enemy : SlimeNode = SlimeNode(imageNamed: "slime1")
        enemy.runAction(SKAction.repeatActionForever(action))
        return enemy
    }
    
    // タイトルでただフワフワしてるだけのスライム
    class func makeDemo()-> SlimeNode {
        let enemy = SlimeAnimateNode()
        enemy.name = "slime"
        enemy.zPosition = 999
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(CGFloat(32), CGFloat(32)))
        physic.affectedByGravity = true
        physic.allowsRotation = true
        physic.categoryBitMask = blockCategory
        physic.collisionBitMask = heroCategory | worldCategory | downWorldCategory | horizonWorldCategory | swordCategory | wallCategory
        physic.restitution = 0.9
        enemy.physicsBody = physic
        return enemy
    }

}