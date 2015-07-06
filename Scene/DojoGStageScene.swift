import SpriteKit
class DojoGStageScene: PlayScene {
    
    override func setStageValue() {
        _distance = 100
    }
    
    // 敵を作成
    override func generateNormalEnemy(){
        makeApple()
    }
    
    override func generateHardEnemy(){
        makeApple()
        makeBlock(7)
    }
    
    override func generateSpecialEnemy(){
        makeApple()
        makeBlock(6)
    }
    override func makeBoss(){
        var enemy = GolemNode.makeEnemy()
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        self.addChild(enemy)
    }
}