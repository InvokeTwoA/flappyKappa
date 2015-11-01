import SpriteKit
class KettouStageScene: PlayScene {
    
    override func setStageValue() {
        _distance = 50
    }
    
    // 敵を作成
    override func generateEnemy(){
        makeMetalSlime()
    }
    
    override func makeBoss(danjon_type : String){
        let enemy = MaoNode.makeEnemy(_danjon_type)
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMidY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        enemy.name = "boss"
        _bossName = enemy.userData?.valueForKey("name") as! String
        self.addChild(enemy)
        
        Maoworp()
    }
}