import SpriteKit
class MugenStageScene: PlayScene {
    
    override func setStageValue() {
        //        _distance = 2500
        _distance = 5000
    }
    
    override func setBGM(){
        prepareBGM("last_boss")
    }
    
    // 敵を作成
    override func generateEnemy(){
        makeApple()
        makeBlock(10)
        makeAllBlock(18)
        makeSlime(25)
        makeSuperSlime(15)
        makeSister(20)
        makeWitch(25)
        makeFighter(5)
        makeSkelton(5)
        makeGhost(5)
        
        // boss
        makeGolem()
        makeBigSlime()
        makeKnight()
        makeBigGhost()
    }
    
    override func makeBoss(danjon_type : String){
        let enemy = MaoNode.makeEnemy(_danjon_type)
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMidY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        enemy.name = "maou"
        self.addChild(enemy)
        
        worp()
    }
    
    func worp(){
        let mao : MaoNode? = childNodeWithName("maou") as? MaoNode
        if mao == nil {
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
    
    
    func makeGolem(){
        if(CommonUtil.rnd(100) > 5) {
            return
        }
        
        let enemy = GolemNode.makeEnemy(_danjon_type)
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        self.addChild(enemy)
    }
    
    func makeBigSlime(){
        if(CommonUtil.rnd(100) > 5) {
            return
        }

        let enemy = BigSlimeNode.makeEnemy(_danjon_type)
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        self.addChild(enemy)
    }
    
    
    // 敵を撃破
    override func beatEnemy(enemyNode: SKSpriteNode){
        let gold = enemyNode.userData?.valueForKey("gold") as! Int
        makeCoin(gold, location: CGPointMake(enemyNode.position.x, enemyNode.position.y))
        
        // ゾンビ状態ならば HP を回復
        // FIXME レベルが上がるとHP吸収量が上がる？
        if _zombi_flag {
            _hp += 1
            changeLifeLabel()
            changeLifeBar()
        }
        
        if enemyNode.name == "maou" {
            beatBoss()
            makeSpark(enemyNode.position)
            makeSpark(CGPointMake(enemyNode.position.x + 50, enemyNode.position.y + 50))
            makeSpark(CGPointMake(enemyNode.position.x - 50, enemyNode.position.y - 50))
            makeSpark(CGPointMake(enemyNode.position.x - 50, enemyNode.position.y + 50))
            makeSpark(CGPointMake(enemyNode.position.x + 50, enemyNode.position.y - 50))
            _boss_beat_flag = true
            NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("setGameEndFlag"), userInfo: nil, repeats: false)
        }
        enemyNode.removeFromParent()
    }
    
    
    func makeKnight(){
        if(CommonUtil.rnd(100) > 5) {
            return
        }
        let enemy = KnightNode.makeEnemy(_danjon_type)
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        _bossName = enemy.userData?.valueForKey("name") as! String
        self.addChild(enemy)
    }
    
    func makeBigGhost(){
        if(CommonUtil.rnd(100) > 5) {
            return
        }
        let enemy = BossGhostNode.makeEnemy(_danjon_type)
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        _bossName = enemy.userData?.valueForKey("name") as! String
        self.addChild(enemy)
    }
    
}