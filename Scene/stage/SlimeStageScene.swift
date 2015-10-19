import SpriteKit
class SlimeStageScene: PlayScene {
    
    override func setStageValue() {
        _distance = 2000
    }
    
    // 敵を作成
    override func generateNormalEnemy(){
        makeApple()
        makeBlock(10)
        makeSlime(40)
        makeGhost(10)
    }
    
    override func generateHardEnemy(){
        makeApple()
        makeBlock(9)
        makeSlime(60)
        makeGhost(30)
    }
    
    override func generateSpecialEnemy(){
        makeApple()
        makeBlock(7)
        makeSlime(85)
        makeSkelton(85, lv: 1)
    }
    
    override func makeBoss(){
        var enemy = BigCatNode.makeEnemy()
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        _bossName = "巨大ネコ"
        _bossHP = enemy.userData?.valueForKey("hp") as! Int
        self.addChild(enemy)
    }
}