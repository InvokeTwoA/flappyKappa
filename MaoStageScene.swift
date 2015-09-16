import SpriteKit
class MaoStageScene: PlayScene {
    
    override func setStageValue() {
//        _distance = 3000
        _distance = 3
    }
    
    // 敵を作成
    override func generateNormalEnemy(){
        makeApple()
        makeBlock(7)
    }
    
    override func generateHardEnemy(){
        makeApple()
        makeBlock(6)
    }
    
    override func generateSpecialEnemy(){
        makeApple()
        makeBlock(5)
    }
    
    override func makeBoss(){
        var enemy = MaoNode.makeEnemy()
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        self.addChild(enemy)
    }
}