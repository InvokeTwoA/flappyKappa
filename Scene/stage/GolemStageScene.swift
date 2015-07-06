import SpriteKit
class GolemStageScene: PlayScene {
    
    // 敵を作成
    override func generateNormalEnemy(){
        makeApple()
        makeBlock(10)
        makeSlime(30)
        makeSkelton(10, lv: 3)
    }

    override func generateHardEnemy(){
        makeApple()
        makeBlock(7)
        makeSlime(40)
        makeSkelton(35, lv: 5)
    }

    override func generateSpecialEnemy(){
        makeApple()
        makeBlock(6)
        makeSlime(75)
        makeSkelton(40, lv: 10)
    }
    override func makeBoss(){
        var enemy = GolemNode.makeEnemy()
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        self.addChild(enemy)
    }
}