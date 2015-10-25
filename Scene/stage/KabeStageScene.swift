import SpriteKit
class KabeStageScene: PlayScene {
    
    override func setStageValue() {
        _distance = 3000
    }
    
    // 敵を作成
    override func generateEnemy(){
        makeApple()
        makeAllBlock(2)
        makeSuperSlime(15)
        makeSister(5)
        makeFighter(5)
        makeMetalSlime()
    }
    
    override func makeBoss(danjon_type : String){
        var enemy = BigSlimeNode.makeEnemy(danjon_type)
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        
        _bossName = enemy.userData?.valueForKey("name") as! String
        self.addChild(enemy)
    }
}