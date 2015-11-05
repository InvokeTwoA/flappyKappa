import SpriteKit
class WhiteStageScene: PlayScene {
    
    override func setStageValue() {
        _distance = 2000
    }
    
    override func setBackGroundImage(){
        self.backgroundColor = UIColor(red:1.0,green:1.0,blue:1.0,alpha:1.0)
        _textColor = UIColor.blackColor()
    }
    
    // 敵を作成
    override func generateEnemy(){
        makeApple()
        makeBlock(13)
        makeMiira(20)
        makeSister(20)
        makeFighter(20)
    }
    
    override func makeBoss(danjon_type : String){
        let enemy = ShadowNode.makeEnemy(_danjon_type)
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMidY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        enemy.name = "boss"
        _bossName = enemy.userData?.valueForKey("name") as! String
        self.addChild(enemy)
    }

    override func copyJump(){
        if _distance > 0 {
            return
        }
        let enemy = childNodeWithName("boss")
        if enemy == nil {
            return
        }
        let jump : CGFloat = CGFloat(400+_agi)
        enemy!.physicsBody!.velocity = CGVectorMake(0, jump)
        makeSuperSlime(100)
    }
    
    override func copyRight(){
        if _distance > 0 {
            return
        }
        let enemy = childNodeWithName("boss")
        if enemy == nil {
            return
        }
        enemy!.physicsBody?.applyImpulse(CGVectorMake(CGFloat(-1*_agi), 0))
    }
    
    override func copyLeft(){
        if _distance > 0 {
            return
        }
        let enemy = childNodeWithName("boss")
        if enemy == nil {
            return
        }
        enemy!.physicsBody?.applyImpulse(CGVectorMake(CGFloat(_agi), 0))

    }

}