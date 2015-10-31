import SpriteKit
class MahoStageScene: PlayScene {
    
    override func setStageValue() {
        _distance = 2000
    }
    
    // 敵を作成
    override func generateEnemy(){
        makeApple()
        makeSuperSlime(15)
        makeSister(30)
        makeWitch(5)
        makeMetalSlime()
    }
    override func setSword(from: CGPoint, to: CGPoint){
        return
    }
    
    override func makeBoss(danjon_type : String){
        let enemy = GolemNode.makeEnemy(_danjon_type)
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        _bossName = enemy.userData?.valueForKey("name") as! String
        self.addChild(enemy)
    }
}