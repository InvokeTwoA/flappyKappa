import SpriteKit
class TanukiStageScene: PlayScene {
    
    override func setStageValue() {
        _distance = 400
    }
    
    // 敵を作成
    override func generateNormalEnemy(){
        makeApple()
        makeSlime(30)
        makeCat(5)
    }
    
    override func generateHardEnemy(){
        makeApple()
        makeBlock(9)
        makeSlime(60)
        makeCat(30)
    }
    
    override func generateSpecialEnemy(){
        makeApple()
        makeBlock(7)
        makeSlime(85)
        makeSkelton(85, lv: 1)
    }
    
    override func makeBoss(){
        var enemy = TanukiNode.makeEnemy()
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        _bossName = "たぬきマン"
        _bossHP = enemy.userData?.valueForKey("hp") as! Int
        self.addChild(enemy)
    }
}