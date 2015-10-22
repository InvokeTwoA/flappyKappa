import SpriteKit
class MaoStageScene: PlayScene {
    
    override func setStageValue() {
//        _distance = 2500
        _distance = 1500
    }
    
    override func setBGM(){
        prepareBGM("last_boss")
    }

    
    // 敵を作成
    override func generateEnemy(){
        makeApple()
        makeBlock(10)
        makeSuperSlime(25)
        makeSister(30)
        makeWitch(25)
        makeFighter(5)
    }
    
    override func makeBoss(danjon_type : String){
        var enemy = MaoNode.makeEnemy(_danjon_type)
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMidY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        enemy.name = "boss"
        _bossName = enemy.userData?.valueForKey("name") as! String
        self.addChild(enemy)

        worp()
    }
    
    func worp(){
        var mao : MaoNode? = childNodeWithName("boss") as? MaoNode
        if mao == nil {
            print("mao not exist")
            return
        }

        // ワープ時に敵を召喚
        for var i=0; i<10;i++ {
            makeGhost(100)
            
        }
        makeSkelton(100)
        
        let height: Int = CommonUtil.rnd(Int(_stageHeight) - 40) + CommonConst.footerHeight
        let point_x : Int = CommonUtil.rnd(Int(CGRectGetMaxX(self.frame)-80)) + 40
        let point : CGPoint = CGPointMake(CGFloat(point_x), CGFloat(height))
        mao!.position = point
        
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("worp"), userInfo: nil, repeats: false)
    }
}