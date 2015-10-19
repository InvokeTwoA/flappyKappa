// プレイ画面
import SpriteKit
import AVFoundation

class PlayScene: BaseScene, AVAudioPlayerDelegate {
    // 初期値をデータから取得
    var _hp : Int       = CommonData.getDataByInt("hp")
    var _maxhp : Int    = CommonData.getDataByInt("hp")
    var _str : Int      = CommonData.getDataByInt("str")
    var _int : Int      = CommonData.getDataByInt("int")
    var _pri : Int      = CommonData.getDataByInt("pri")

    var _danjon_type :String = "normal"
    var _distance : Int = 1000
    var _score : Int = 0
    var _tapCount : Int = 0             // タップした回数
    var _game_end_flag : Bool = false  // ゲーム終了フラグ
    var _boss_flag : Bool = false // ボス登場フラグ
    var _boss_beat_flag : Bool = false // ボス撃破フラグ
    

    var _bossName : String = "ボス"
    var _bossHP : Int = 999
    
    // スキル用のフラグ（CommonDataへのアクセスは初回のみで、クラス変数のフラグに格納）
    var _equip = CommonData.getDataByString("equip_weapon")
    var _fire_penetrate_flag : Bool = false
    var _fireSpeed : Int = CommonConst.fire_speed
    var _apple_per : Int = CommonConst.apple_per
    var _break_block_flag : Bool = false
    var _zombi_flag : Bool = false

    var _lifeBarWidth : CGFloat = 0.0
    var _stageHeight : CGFloat = 0.0
    var _lastUpdateTimeInterval : NSTimeInterval = 0
    var _timeSinceStart : NSTimeInterval = 0
    var _timeSinceLastSecond : NSTimeInterval = 0
    
    var _audioPlayer:AVAudioPlayer!
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.0,green:0.0,blue:0.0,alpha:1.0)
        setBaseSetting()
        setBackGroundImage()
        setInitData()
        setStageValue()
        setFooter()
        setDistance()
        
        setBGM()
        playBGM()
    }
    
    func setBGM(){
        prepareBGM("battle")
    }

    func prepareBGM(fileName : String){
        let bgm_path = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(fileName, ofType: "mp3")!)
        var audioError:NSError?
        _audioPlayer = AVAudioPlayer(contentsOfURL: bgm_path, error:&audioError)
        if let error = audioError {
            println("Error \(error.localizedDescription)")
        }
        _audioPlayer.delegate = self
        _audioPlayer.prepareToPlay()
    }
    
    func playBGM(){
        if ( !_audioPlayer.playing ){
            _audioPlayer.play()
        }
    }

    func stopBGM(){
        if ( _audioPlayer.playing ){
            _audioPlayer.stop()
        }
    }
    
    func attackBGM(){
        var action : SKAction = SKAction.playSoundFileNamed("attack.wav", waitForCompletion: true)
        self.runAction(action)
    }
    
    func damagedBGM(){
        var action : SKAction = SKAction.playSoundFileNamed("damaged.wav", waitForCompletion: true)
        self.runAction(action)
    }
    
    func coinBGM(){
        var action : SKAction = SKAction.playSoundFileNamed("coin.wav", waitForCompletion: true)
        self.runAction(action)
    }
    
    
    func setStageValue(){
    
    }
    
    func setBackGroundImage(){
        return
        /*
        let backView = SKSpriteNode(imageNamed: "bg_night")
        backView.position = CGPointMake(self.size.width, self.size.height - CGFloat(CommonConst.headerHeight))
        backView.zPosition = 0
        backView.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.moveToX(-200.0, duration: 20.0),
                SKAction.moveToX(self.size.width+200, duration: 0.0)])))
        self.addChild(backView)
*/
    }
    
    override func setSlimeDemo() {
    }
    
    override func swipeRight(gesture: UISwipeGestureRecognizer){
        scoreUp(2)
        var kappa : KappaNode? = childNodeWithName("kappa") as? KappaNode
        kappa?.physicsBody?.applyImpulse(CGVectorMake(CGFloat(_agi + 5 ), 0))
    }

    override func swipeLeft(gesture: UISwipeGestureRecognizer){
        scoreUp(1)
        showMoney()
        var kappa : KappaNode? = childNodeWithName("kappa") as? KappaNode
        kappa?.physicsBody?.applyImpulse(CGVectorMake(CGFloat(-1*_agi - 5), 0))
    }
    
    // 初期値をセット
    func setInitData(){
        setMoney()
        _lifeBarWidth = self.frame.size.width - 100
        _stageHeight = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.footerHeight)
         _danjon_type = CommonData.getData("danjon_type") as! String

        setSkill()
    }
    
    func setSkill(){
        // スキル設定
        if(CommonData.getDataByInt("skill_warrior") == 1){
            _swordSpeed = CommonConst.swordHighSpeed
        }
        if(CommonData.getDataByInt("skill_priest") == 1){
            _apple_per = CommonConst.apple_per_high
        }
        if(CommonData.getData("skill_wizard") as! Int == 1){
            _fire_penetrate_flag = true
        }
        if(CommonData.getData("skill_break_block") as! Int == 1){
            _break_block_flag = true
        }
        if(CommonData.getDataByInt("skill_zombi") == 1 && CommonData.getDataByString("nickname") == "ゾンビ"){
            _zombi_flag = true
        }
        
        // 装備による変化
        if _equip == "katana" {
            _maxhp = 2
            _hp = 2
        } else if _equip == "shoes" {
            _agi = CommonConst.agi_max
        }
        
        
    }
    
    // ライフなどを表示するフッターを表示
    func setFooter(){
        let point : CGPoint = CGPoint(x:CGRectGetMidX(frame), y: CGRectGetMinY(frame) + CGFloat(CommonConst.footerHeight)/2)
        let size : CGSize = CGSizeMake(CGRectGetMaxX(frame), CGFloat(CommonConst.footerHeight))
        var footer : SKSpriteNode = SKSpriteNode(color: UIColor.cyanColor(), size: size)
        footer.position = point
        footer.name = "footer_status"
        footer.zPosition = 10
        let physic = SKPhysicsBody(rectangleOfSize: size)
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.dynamic = false
        physic.categoryBitMask = downWorldCategory
        footer.physicsBody = physic
        
        var blackBar = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(_lifeBarWidth, CGFloat(CommonConst.lifeBarHeight)))
        blackBar.position = CGPointMake(-1*CGRectGetMidX(self.frame) + 30, -20)
        blackBar.anchorPoint = CGPointMake(0, 0)
        blackBar.zPosition = 11
        footer.addChild(blackBar)
        
        var yellowBar = SKSpriteNode(color: UIColor.yellowColor(), size: CGSizeMake(_lifeBarWidth, CGFloat(CommonConst.lifeBarHeight)))
        yellowBar.position = CGPointMake( -1 * CGRectGetMidX(self.frame) + 30, -20)
        yellowBar.name = "life_bar"
        yellowBar.anchorPoint = CGPointMake(0, 0)
        yellowBar.zPosition = 12
        footer.addChild(yellowBar)
        
        var hpLabel :SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        hpLabel.position = CGPointMake(-1 * CGRectGetMidX(self.frame)/2, 20)
        hpLabel.fontSize = 18
        hpLabel.text = "HP : \(_hp) / \(_maxhp)"
        hpLabel.name = "hp_label"
        hpLabel.fontColor = UIColor.blackColor()
        footer.addChild(hpLabel)
        
        self.addChild(footer)
    }
    
    // 残りの距離を表示
    func setDistance(){
        var distanceLabel = SKLabelNode(fontNamed: CommonConst.font_regular)
        distanceLabel.position = CGPointMake(CGRectGetMinX(self.frame) + 10, CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight) )
        distanceLabel.name = "distance"
        distanceLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        distanceLabel.text = "残り \(_distance) m"
        self.addChild(distanceLabel)
    }

    // 敵を作成
    func generateEnemy(){
        if _danjon_type == "normal" {
            generateNormalEnemy()
        } else if _danjon_type == "hard" {
            generateHardEnemy()
        } else if _danjon_type == "special" {
            generateSpecialEnemy()
        }
    }

    // ボスを作成
    func makeBoss(){
    }
    
    // 通常難易度の敵作成(子クラスで記述)
    func generateNormalEnemy(){
    }

    // ハードの敵作成(子クラスで記述)
    func generateHardEnemy(){
    }
    // カッパ級の敵作成(子クラスで記述)
    func generateSpecialEnemy(){
    }
    
    func makeSlime(per : Int){
        if(CommonUtil.rnd(100) < per) {
            var enemy = SlimeNode.makeEnemy()
            let enemy_harf_height : Int = enemy.half_height
            let min_height: Int = CommonConst.footerHeight + enemy_harf_height
            let height: Int = CommonUtil.rnd(Int(_stageHeight) - enemy_harf_height)
            let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame), CGFloat(min_height + height))
            enemy.position = point
            self.addChild(enemy)
        }
    }
    
    func makeSuperSlime(per : Int){
        if(CommonUtil.rnd(100) < per) {
            var enemy = SlimeNode.makeSuperEnemy()
            let enemy_harf_height : Int = enemy.half_height
            let min_height: Int = CommonConst.footerHeight + enemy_harf_height
            let height: Int = CommonUtil.rnd(Int(_stageHeight) - enemy_harf_height)
            let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame), CGFloat(min_height + height))
            enemy.position = point
            self.addChild(enemy)
        }
    }


    func makeGhost(per : Int){
        if(CommonUtil.rnd(100) < per) {
            var enemy = GhostNode.makeEnemy()
            let enemy_harf_height : Int = enemy.half_height
            let min_height: Int = CommonConst.footerHeight + enemy_harf_height
            let height: Int = CommonUtil.rnd(Int(_stageHeight) - enemy_harf_height)
            let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame), CGFloat(min_height + height))
            enemy.position = point

            // カッパに向かって突撃してくる
            var kappa : KappaNode? = childNodeWithName("kappa") as? KappaNode
            var action : SKAction = SKAction.moveTo(kappa!.position, duration: 3)
            action.timingMode = SKActionTimingMode.EaseIn
            enemy.runAction(action, completion:
                {
                    //enemy.physicsBody?.velocity = CGVectorMake(-40, 0)
                    enemy.removeFromParent()
                }
            )
            
            self.addChild(enemy)
        }
    }
    
    func makeSkelton(per : Int, lv : Int){
        if(CommonUtil.rnd(100) < per) {
            var enemy = SkeltonNode.makeEnemy(lv)
            let min_height: Int = CommonConst.footerHeight + enemy._height/2
            let point = CGPointMake(CGRectGetMaxX(self.frame), CGFloat(min_height))
            enemy.position = point
            enemy.setPhysic()
            enemy.zPosition = 1
            self.addChild(enemy)
        }
    }
    
    // 回復アイテムを低確率で出現
    func makeApple(){
        if(CommonUtil.rnd(100) < _apple_per) {
            var node = AppleNode.makeApple()
            let min_height: Int = CommonConst.footerHeight + node._height/2
            let height: Int = CommonUtil.rnd(Int(_stageHeight) - Int(node._height/2))
            let point = CGPointMake(CGRectGetMaxX(self.frame), CGFloat(min_height + height))
            node.position = point
            self.addChild(node)
        }
    }
    
    func makeBlock(interval: Int){
        // interval秒に１回　ブロックを出現
        if Int(_timeSinceStart)%interval != 0 {
            return
        }
        
        let total_block = Int(_stageHeight)/CommonConst.block_width
        
        // 上ブロックを作成 0~3
        let up_block_num = CommonUtil.rnd(total_block - 6)
        for ( var i = 0; i < up_block_num ; i++ ) {
            var upNode = BlockNode.makeBlock()
            let point_y : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight) - upNode.half_height - upNode.height*CGFloat(i)
            let point = CGPointMake(CGRectGetMaxX(self.frame), point_y)
            upNode.position = point
            self.addChild(upNode)
        }
        
        let down_block_num = total_block - up_block_num - 6
        
        for ( var i = 0; i < down_block_num ; i++ ) {
            var downNode = BlockNode.makeBlock()
            let point_y : CGFloat = CGFloat(CommonConst.footerHeight) + downNode.half_height + downNode.height*CGFloat(i)
            let point = CGPointMake(CGRectGetMaxX(self.frame), point_y)
            downNode.position = point
            self.addChild(downNode)
        }
    }
    
    override func setBattleTap(){
        scoreUp(1)
        _tapCount += 1
        
        var kappa : KappaNode? = childNodeWithName("kappa") as? KappaNode        
        // 10回タップ毎に１回ファイアボールを発動
        if(_tapCount%10 == 0){
            setFireBall(kappa!.position)
        }
    }
    
    
    override func isCritical() -> Bool{
        return CommonUtil.rnd(100) < _luck || _equip == "katana"
    }
    
    
    func setFireBall(location: CGPoint){
        var fire = FireNode.make(location)
        self.addChild(fire)
        fire.physicsBody?.velocity = CGVectorMake(CGFloat(_fireSpeed), 0)
    }

    override func didBeginContact(contact: SKPhysicsContact) {
        var firstBody, secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 主人公の衝突判定
        if (firstBody.categoryBitMask & heroCategory != 0 ) {
            if secondBody.categoryBitMask & enemyCategory != 0 {
                makeSpark(firstBody.node?.position)
                let damage = secondBody.node?.userData?.valueForKey("str") as! Int
                damaged(damage)
                displayDamage(damage, point: firstBody.node!.position, color: UIColor.redColor())
                return
            } else if secondBody.categoryBitMask & itemCategory != 0 {
                getApple(secondBody)
                return
            } else if secondBody.categoryBitMask & coinCategory != 0 {
                let val = secondBody.node?.userData?.objectForKey("gold") as! Int
                _gold += val
                showMoney()
                coinBGM()
                secondBody.node?.removeFromParent()
                displayDamage(val, point: secondBody.node!.position, color: UIColor.yellowColor())
                return
            } else if secondBody.categoryBitMask & blockCategory != 0 {
                makeSpark(firstBody.node?.position)
                let damage = 1
                damaged(damage)
                displayDamage(damage, point: firstBody.node!.position, color: UIColor.redColor())
                secondBody.node?.removeFromParent()
                return
            } else if secondBody.categoryBitMask & wallCategory != 0 {
                makeSpark(firstBody.node?.position)
                let damage = 1
                damaged(damage)
                displayDamage(damage, point: firstBody.node!.position, color: UIColor.redColor())
                return
            } else if secondBody.categoryBitMask & goalCategory != 0 {
                _game_end_flag = true
                secondBody.node?.removeFromParent()
                return
            }
        }

        // 敵の衝突判定
        if (firstBody.categoryBitMask & enemyCategory != 0 ) {
            if secondBody.categoryBitMask & worldCategory != 0 {
                firstBody.node?.removeFromParent()
            } else if secondBody.categoryBitMask & fireCategory != 0 {
                makeSpark(firstBody.node?.position)
                displayDamage(_int, point: firstBody.node!.position, color: UIColor.whiteColor())
                hitFire(firstBody, fireBody: secondBody)
            } else if secondBody.categoryBitMask & swordCategory != 0 {
                hitSword(firstBody,swordBody: secondBody)
            }
        }
        
        // 炎の衝突判定
        if (firstBody.categoryBitMask & fireCategory != 0 ) {
            if secondBody.categoryBitMask & worldCategory != 0 {
                firstBody.node?.removeFromParent()
            }
        }
        
        // 剣の衝突判定
        if (firstBody.categoryBitMask & swordCategory != 0 ) {
            if secondBody.categoryBitMask & worldCategory != 0 {
                firstBody.node?.removeFromParent()
            } else if secondBody.categoryBitMask & blockCategory != 0 {
                makeSpark(firstBody.node?.position)
                if _break_block_flag {
                    secondBody.node?.removeFromParent()
                    scoreUp(1)
                }
                firstBody.node?.removeFromParent()
            }
        }
        
        // アイテム
        if (firstBody.categoryBitMask & itemCategory != 0 ) {
            if secondBody.categoryBitMask & horizonWorldCategory != 0 {
                firstBody.node?.removeFromParent()
            }
        }
        // コイン
        if (firstBody.categoryBitMask & coinCategory != 0 ) {
            if secondBody.categoryBitMask & horizonWorldCategory != 0 {
                firstBody.node?.removeFromParent()
            }
        }


    }
    
    // 衝突時など、火花を出す
    func makeCriticalSpark(location: CGPoint?){
        let particle = SparkEmitterNode.makeSpark("CriticalSpark")
        particle.position = location!
        particle.zPosition = 1
        self.addChild(particle)
    }

    
    func makeCoin(gold : Int, location: CGPoint?){
        var coin : CoinNode = CoinNode.makeCoin(gold)
        let point = location!
        coin.position = location!
        coin.setPhysic()
        self.addChild(coin)
    }
    
    // 回復アイテムを取得
    func getApple(body: SKPhysicsBody){
        if _zombi_flag {
            _hp -= 20
        } else {
            _hp += _pri
            scoreUp(10)
        }
        changeLifeLabel()
        changeLifeBar()
        displayDamage(_pri, point: body.node!.position, color: UIColor.greenColor())
        body.node!.removeFromParent()
    }
    
    // 炎が当たった時の処理
    func hitFire(firstBody: SKPhysicsBody, fireBody: SKPhysicsBody){
        attackBGM()
        let enemyNode: SKSpriteNode = firstBody.node as! SKSpriteNode
        if _fire_penetrate_flag == false {
            fireBody.node?.removeFromParent()
        }
        var enemyHP : Int = enemyNode.userData?.valueForKey("hp") as! Int
        if((enemyNode.physicsBody!.categoryBitMask & magicArmerCategory) != 0) {
            enemyHP -= 1
            if enemyNode.name == "boss" {
                _bossHP -= 1
                showBossName()
            }
        } else {
            enemyHP -= _int
            if enemyNode.name == "boss" {
                _bossHP -= _int
                showBossName()
            }
        }
        
        if(enemyHP <= 0){
            beatEnemy(enemyNode)
        } else {
            enemyNode.userData?.setValue(enemyHP, forKey: "hp")
        }
    }

    // 剣が当たった時の処理
    func hitSword(firstBody: SKPhysicsBody, swordBody: SKPhysicsBody){
        attackBGM()
        let enemyNode: SKSpriteNode = firstBody.node as! SKSpriteNode

        var enemyHP : Int = enemyNode.userData?.valueForKey("hp") as! Int
        var enemyDef : Int = enemyNode.userData?.valueForKey("def") as! Int
        var damage : Int = 1
        
        if swordBody.node?.name == "critical" {
            scoreUp(3)
            makeCriticalSpark(swordBody.node?.position)
            damage = _str - enemyDef/2 + CommonUtil.rnd(_luck)
            if damage <= 1 {
                damage = 2
            }
        } else {
            makeSpark(swordBody.node?.position)
            damage = _str - enemyDef
        }
        if(damage <= 0) {
            damage = 1
        }
        enemyHP -= damage
        if enemyNode.name == "boss" {
            _bossHP -= damage
            showBossName()
        }
        displayDamage(damage, point: firstBody.node!.position, color: UIColor.whiteColor())
        if(enemyHP <= 0){
            beatEnemy(enemyNode)
        } else {
            enemyNode.userData?.setValue(enemyHP, forKey: "hp")
        }
        swordBody.node?.removeFromParent()
    }
    
    // 敵を撃破
    func beatEnemy(enemyNode: SKSpriteNode){
        let gold = enemyNode.userData?.valueForKey("gold") as! Int
        makeCoin(gold, location: CGPointMake(enemyNode.position.x, enemyNode.position.y))
        let score = enemyNode.userData?.valueForKey("score") as! Int
        scoreUp(score)

        // ゾンビ状態ならば HP を回復
        // FIXME レベルが上がるとHP吸収量が上がる？
        if _zombi_flag {
            _hp += 1
            changeLifeLabel()
            changeLifeBar()
        }
        
        if enemyNode.name == "boss" {
            makeSpark(enemyNode.position)
            makeSpark(CGPointMake(enemyNode.position.x + 50, enemyNode.position.y + 50))
            makeSpark(CGPointMake(enemyNode.position.x - 50, enemyNode.position.y - 50))
            makeSpark(CGPointMake(enemyNode.position.x - 50, enemyNode.position.y + 50))
            makeSpark(CGPointMake(enemyNode.position.x + 50, enemyNode.position.y - 50))
            _boss_beat_flag = true
            var timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("setGameEndFlag"), userInfo: nil, repeats: false)
        }
        enemyNode.removeFromParent()
    }
    
    func setGameEndFlag(){
        _game_end_flag = true
        stageClear()
    }

    // 敵と衝突し、ダメージを受ける
    // HPが0以下になったらゲームオーバー
    func damaged(value: Int){
        damagedBGM()
        _hp -= value
        changeLifeBar()
        changeLifeLabel()
        if(_hp <= 0 && _boss_beat_flag != true){
            _game_end_flag = true
            goGameOver()
        }
    }
    
    // ダメージを数字で表示
    func displayDamage(value: Int, point: CGPoint, color: UIColor){
        let location = CGPointMake(point.x, point.y + 50.0)
        var label = SKLabelNode(fontNamed: CommonConst.font_regular)
        label.text = "\(value)"
        label.position = location
        label.fontColor = color
        label.fontSize = 25
        label.zPosition = 90
        self.addChild(label)
        
        var fade : SKAction = SKAction.fadeOutWithDuration(4)
        label.runAction(fade)
    }
    

    // HPに変化があったのでライフバーを変更
    func changeLifeBar(){
        var life_bar : SKSpriteNode? = childNodeWithName("footer_status")?
            .childNodeWithName("life_bar") as? SKSpriteNode
        let width: Double = Double(_hp)/Double(_maxhp) * Double(_lifeBarWidth)
        life_bar!.size = CGSizeMake(CGFloat(width), CGFloat(CommonConst.lifeBarHeight))
    }

    // HPに変化があったのでライフバーを変更
    func changeLifeLabel(){
        if _hp <= 0 {
            _hp = 0
        } else if _hp > _maxhp {
            _hp = _maxhp
        }
        
        var life_label : SKLabelNode? = childNodeWithName("footer_status")?
            .childNodeWithName("hp_label") as? SKLabelNode
        let width: Double = Double(_hp)/Double(_maxhp) * Double(_lifeBarWidth)
        life_label!.text = "HP : \(_hp) / \(_maxhp)"
    }
    
    // 画面外にいるキャラを削除
    func worldEnd(){
        self.enumerateChildNodesWithName("enemy", usingBlock: {
            (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            if node.position.x < 0 {
                node.removeFromParent()
            }
        })
        self.enumerateChildNodesWithName("fire", usingBlock: {
            (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            if node.position.x < 0 {
                node.removeFromParent()
            } else if node.position.x > self.frame.size.width {
                node.removeFromParent()
            }
        })
    }
    
    func showDistance(){
        var distanceLabel : SKLabelNode? = childNodeWithName("distance") as? SKLabelNode
        var distance = CommonUtil.displayDistance(_distance)
        distanceLabel?.text = "残り \(distance)"
        distanceLabel?.zPosition = 3
    }
    
    func showMoney(){
        var goldLabel : SKLabelNode? = childNodeWithName("header_status")?.childNodeWithName("gold_label") as? SKLabelNode
        var gold = CommonUtil.displayMoney(_gold)
        goldLabel?.text = gold
    }
    

    func showBossName(){
        var distanceLabel : SKLabelNode? = childNodeWithName("distance") as? SKLabelNode
        var distance = CommonUtil.displayDistance(_distance)
        if(_bossHP >= 0 ){
            //distanceLabel?.text = "ボス  \(_bossName)　HP: \(_bossHP)"
            distanceLabel?.text = "\(_bossName) HP:\(_bossHP)"
        } else {
            distanceLabel?.text = "ボス撃破!!!!"
        }
        distanceLabel?.zPosition = 3
    }
    
    func stageClear(){
        goGameClearScene()
    }
    
    // ゲームオーバー画面へ
    func goGameOver(){
        stopBGM()
        let secondScene = GameOverScene(size: self.frame.size)
        let tr = SKTransition.fadeWithColor(UIColor.whiteColor(), duration: 4)
        changeSceneWithLongDuration(secondScene, tr: tr, duration: 4)
    }
    
    func goGameClearScene() {
        stopBGM()
        CommonData.setData("stage_score", value: _score)
        dataSave()
        let secondScene = GameClearScene(size: self.frame.size)
        let tr = SKTransition.fadeWithColor(UIColor.whiteColor(), duration: 4)
        changeSceneWithLongDuration(secondScene, tr: tr, duration: 4)
    }
    
    // 画面遷移時、データを保存する
    func dataSave(){
        CommonData.setData("gold", value: _gold)
    }
    
    func scoreUp(value : Int){
        _score += value
        showMoney()
    }
    
    override func update(currentTime: CFTimeInterval) {
        // ボス撃破したので終了
        if(_game_end_flag == true) {
            //goGameClearScene()
            return
        }
        
        // 時間関係の処理
        let timeSinceLast : CFTimeInterval = currentTime - _lastUpdateTimeInterval
        _timeSinceStart += timeSinceLast
        _timeSinceLastSecond += timeSinceLast
        if (_timeSinceLastSecond >= 1) {
            _timeSinceLastSecond = 0
            generateEnemy()
        }
        _lastUpdateTimeInterval = currentTime
        
        // 距離の処理。目的地についたらボス登場
        _distance -= 1
        if _distance >= 0 {
            showDistance()
        }
        if(_distance <= 0 && _boss_flag == false){
            _boss_flag = true
            makeBoss()
            showBossName()
        }
        worldEnd()
    }
}