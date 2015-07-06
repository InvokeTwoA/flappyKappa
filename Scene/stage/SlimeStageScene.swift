import SpriteKit
class SlimeStageScene: PlayScene {
    
    // 敵を作成
    override func generateNormalEnemy(){
        makeApple()
        makeBlock(10)
        makeSlime(40)
        makeCat(10)
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
        var enemy = BigCatNode.makeEnemy()
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        self.addChild(enemy)
    }
}