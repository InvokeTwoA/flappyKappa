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

    var _bgm_off : Bool          = CommonData.getDataByBool("bgm_off")
    var _attack_bgm_off : Bool   = CommonData.getDataByBool("attack_bgm_off")
    var _attacked_bgm_off : Bool = CommonData.getDataByBool("attacked_bgm_off")
    var _coin_bgm_off : Bool     = CommonData.getDataByBool("coin_bgm_off")
    
    var _highScore : Int = CommonData.getDataByInt("work_high_score")
    
    var _distance : Int = 1000
    var _tapCount : Int = 0             // タップした回数
    var _game_end_flag : Bool = false  // ゲーム終了フラグ
    var _boss_flag : Bool = false // ボス登場フラグ
    var _boss_beat_flag : Bool = false // ボス撃破フラグ
    
    var _bossName : String = "ボス"
    var _bossHP : Int = 999
    
    // スキル用のフラグ（CommonDataへのアクセスは初回のみで、クラス変数のフラグに格納）
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
    
    var _textColor : UIColor = UIColor.whiteColor()    
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.0,green:0.0,blue:0.0,alpha:1.0)
        setBaseSetting()
        setBackGroundImage()
        setInitData()
        setFooter()
        setStageValue()
        setDistance()
        if _job == "遊び人" {
            _distance = 10
        }
        
        setBGM()
        playBGM()
    }
    
    func setBGM(){
        prepareBGM("battle")
    }

    func prepareBGM(fileName : String){
        let bgm_path = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(fileName, ofType: "mp3")!)
        var audioError:NSError?
        do {
            _audioPlayer = try AVAudioPlayer(contentsOfURL: bgm_path)
        } catch let error as NSError {
            audioError = error
            _audioPlayer = nil
        }
        if let error = audioError {
            print("Error \(error.localizedDescription)")
        }
        _audioPlayer.delegate = self
        _audioPlayer.prepareToPlay()
    }
    
    func playBGM(){
        if _bgm_off {
            return
        }
        _audioPlayer.numberOfLoops = -1;
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
        if _attack_bgm_off {
            return
        }
        let action : SKAction = SKAction.playSoundFileNamed("attack.wav", waitForCompletion: true)
        self.runAction(action)
    }
    
    func damagedBGM(){
        if _attacked_bgm_off {
            return
        }
        let action : SKAction = SKAction.playSoundFileNamed("damaged.wav", waitForCompletion: true)
        self.runAction(action)
    }
    
    func coinBGM(){
        if _coin_bgm_off {
            return
        }
        let action : SKAction = SKAction.playSoundFileNamed("coin.wav", waitForCompletion: true)
        self.runAction(action)
    }
    
    
    func setStageValue(){
    
    }
    
    func setBackGroundImage(){
        return
        /*
        let backView = SKSpriteNode(imageNamed: "background_map")
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
    
    // 初期値をセット
    func setInitData(){
        setMoney()
        _lifeBarWidth = self.frame.size.width - 100
        _stageHeight = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.footerHeight)
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
        if(CommonData.getDataByInt("skill_wizard") == 1){
            _fire_penetrate_flag = true
        }
        if(CommonData.getDataByInt("skill_break_block") == 1 || _equip == "hammer" || _equip == "soul" || _equip == "bringer" || _equip == "golden" || _job == "大工" ){
            _break_block_flag = true
        }
        if(CommonData.getDataByInt("skill_zombi") == 1){
            _zombi_flag = true
        }
        
        if _job == "勇者" {
            _str += _pri
            _int += _pri
        }
        
        // 装備による変化
        switch _equip {
        case "long":
            _str = 8
        case "katana":
            _maxhp = 2
            _hp = 2
        case "hammer":
            _str += 1
            
        case "oretue":
            _int += 5
        case "soul":
            _str *= 2
            _maxhp *= 2
            _hp *= 2
        case "habel":
            _maxhp = 50
            _hp = 50
        case "kappa_sword":
            _maxhp = 30
            _hp = 30
            _str = _day
        default:
            name = "a"
        }
    }
    
    // ライフなどを表示するフッターを表示
    func setFooter(){
        let point : CGPoint = CGPoint(x:CGRectGetMidX(frame), y: CGRectGetMinY(frame) + CGFloat(CommonConst.footerHeight)/2)
        let size : CGSize = CGSizeMake(CGRectGetMaxX(frame), CGFloat(CommonConst.footerHeight))
        let color : UIColor = UIColor(red:0.2,green:0.2,blue:0.2,alpha:1.0)
        let footer : SKSpriteNode = SKSpriteNode(color: color, size: size)
        footer.position = point
        footer.name = "footer_status"
        footer.zPosition = 10
        let physic = SKPhysicsBody(rectangleOfSize: size)
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.dynamic = false
        physic.categoryBitMask = downWorldCategory
        footer.physicsBody = physic
        
        let blackBar = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(_lifeBarWidth, CGFloat(CommonConst.lifeBarHeight)))
        blackBar.position = CGPointMake(-1*CGRectGetMidX(self.frame) + 30, -20)
        blackBar.anchorPoint = CGPointMake(0, 0)
        blackBar.zPosition = 11
        footer.addChild(blackBar)
        
        let yellowBar = SKSpriteNode(color: UIColor.yellowColor(), size: CGSizeMake(_lifeBarWidth, CGFloat(CommonConst.lifeBarHeight)))
        yellowBar.position = CGPointMake( -1 * CGRectGetMidX(self.frame) + 30, -20)
        yellowBar.name = "life_bar"
        yellowBar.anchorPoint = CGPointMake(0, 0)
        yellowBar.zPosition = 12
        footer.addChild(yellowBar)
        
        let hpLabel :SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        hpLabel.position = CGPointMake(-1 * CGRectGetMidX(self.frame)/2, 20)
        hpLabel.fontSize = 18
        hpLabel.text = "HP : \(_hp) / \(_maxhp)"
        hpLabel.name = "hp_label"
        hpLabel.fontColor = UIColor.whiteColor()
        footer.addChild(hpLabel)
        
        self.addChild(footer)
    }
    
    // 残りの距離を表示
    func setDistance(){
        let distanceLabel = SKLabelNode(fontNamed: CommonConst.font_regular)
        distanceLabel.position = CGPointMake(CGRectGetMinX(self.frame) + 10, CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight) )
        distanceLabel.name = "distance"
        distanceLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        distanceLabel.text = "残り \(_distance) m"
        distanceLabel.zPosition = 999
        self.addChild(distanceLabel)
    }
    
    func setEnemyLife(name: String, life: Int){
        // 以前の表示が残っていたら消す
        let pre_label : SKLabelNode? = childNodeWithName("enemyLife") as? SKLabelNode
        if pre_label != nil {
            pre_label!.removeFromParent()
        }

        let label = SKLabelNode(fontNamed: CommonConst.font_regular)
        label.position = CGPointMake(CGRectGetMinX(self.frame) + 10, CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight*2))
        label.name = "enemyLife"
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        label.fontSize = CGFloat(CommonConst.font_size_normal)
        label.zPosition = 999
        label.fontColor = _textColor

        if(life > 0){
            label.text = "\(name) 残りHP \(life)"
        } else {
            label.text = "\(name)「\(CommonUtil.makeDeathWord())」"
        }
        self.addChild(label)
        
        let fade : SKAction = SKAction.fadeOutWithDuration(4)
        label.runAction(fade)
    }

    // 敵を作成
    func generateEnemy(){
    }

    // ボスを作成
    func makeBoss(danjon_type : String){
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
            let enemy = SlimeNode.makeEnemy(_danjon_type)
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
            let enemy = SlimeNode.makeSuperEnemy(_danjon_type)
            let enemy_harf_height : Int = enemy.half_height
            let min_height: Int = CommonConst.footerHeight + enemy_harf_height
            let height: Int = CommonUtil.rnd(Int(_stageHeight) - enemy_harf_height)
            let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame), CGFloat(min_height + height))
            enemy.position = point
            self.addChild(enemy)
        }
    }

    func makeMetalSlime() {
        if(_luck >= 7 && CommonUtil.rnd(100) < 5) {
            let enemy = SlimeNode.makeMetalEnemy(_danjon_type)
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
            let enemy = GhostNode.makeEnemy(_danjon_type)
            let enemy_harf_height : Int = enemy.half_height
            let min_height: Int = CommonConst.footerHeight + enemy_harf_height
            let height: Int = CommonUtil.rnd(Int(_stageHeight) - enemy_harf_height)
            let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame), CGFloat(min_height + height))
            enemy.position = point

            // カッパに向かって突撃してくる
            let duration : Int = CommonUtil.rnd(4) + 2
            let action : SKAction = SKAction.moveTo(_kappa.position, duration: NSTimeInterval(duration))
            action.timingMode = SKActionTimingMode.EaseIn
            enemy.runAction(action, completion:
                {
                    // 目的地に達したら、後は緩やかに直進
                    enemy.physicsBody?.velocity = CGVectorMake(-40, 0)
                    //enemy.removeFromParent()
                }
            )
            
            self.addChild(enemy)
        }
    }

    func makeFighter(per : Int){
        if(CommonUtil.rnd(100) < per) {
            let enemy = FighterNode.makeEnemy(_danjon_type)
            let enemy_harf_height : Int = enemy.half_height
            let min_height: Int = CommonConst.footerHeight + enemy_harf_height
            let height: Int = CommonUtil.rnd(Int(_stageHeight) - enemy_harf_height)
            let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame), CGFloat(min_height + height))
            enemy.position = point
            
            // カッパに向かって突撃してくる
            let action : SKAction = SKAction.moveTo(_kappa.position, duration: 3)
            action.timingMode = SKActionTimingMode.EaseInEaseOut
            enemy.runAction(action, completion:
                {
                    // 目的地に達したら右に逃げていく
                    enemy.physicsBody?.velocity = CGVectorMake(60, 0)
                }
            )            
            self.addChild(enemy)
        }
    }

    func makeSister(per : Int){
        if(CommonUtil.rnd(100) < per) {
            let enemy = SisterNode.makeEnemy(_danjon_type)
            let enemy_harf_height : Int = enemy.half_height
            let min_height: Int = CommonConst.footerHeight + enemy_harf_height
            let height: Int = Int(_stageHeight) - enemy_harf_height - 20
            let x : Int = 20 + CommonUtil.rnd( Int(CGRectGetMaxY(self.frame)) - 40)
            let point : CGPoint = CGPointMake(CGFloat(x), CGFloat(min_height + height))
            enemy.position = point
            self.addChild(enemy)
        }
    }
    
    func makeMiira(per : Int){
        if(CommonUtil.rnd(100) < per) {
            let enemy = MiiraNode.makeEnemy(_danjon_type)
            let enemy_harf_height : Int = enemy.half_height
            let min_height: Int = CommonConst.footerHeight + enemy_harf_height
            let height: Int = CommonUtil.rnd(Int(_stageHeight) - enemy_harf_height)
            let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame), CGFloat(min_height + height))
            enemy.position = point
            self.addChild(enemy)
        }
    }
    
    func makeWitch(per : Int){
        if(CommonUtil.rnd(100) < per) {
            let enemy = WitchNode.makeEnemy(_danjon_type)
            let enemy_harf_height : Int = enemy.half_height
            let min_height: Int = CommonConst.footerHeight + enemy_harf_height
            let height: Int = CommonUtil.rnd(Int(_stageHeight) - enemy_harf_height)
            let point : CGPoint = CGPointMake(CGRectGetMinX(self.frame), CGFloat(min_height + height))
            enemy.position = point
            self.addChild(enemy)
        }
    }
    
    
    func makeSkelton(per : Int){
        if(CommonUtil.rnd(100) < per) {
            let enemy = SkeltonNode.makeEnemy(_danjon_type)
            let min_height: Int = CommonConst.footerHeight + enemy._height/2 + 50
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
            let node = AppleNode.makeApple()
            let min_height: Int = CommonConst.footerHeight + node._height/2
            let height: Int = CommonUtil.rnd(Int(_stageHeight) - Int(node._height/2))
            let point = CGPointMake(CGRectGetMaxX(self.frame) - 20, CGFloat(min_height + height))
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
            let upNode = BlockNode.makeBlock()
            let point_y : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight) - upNode.half_height - upNode.height*CGFloat(i)
            let point = CGPointMake(CGRectGetMaxX(self.frame), point_y)
            upNode.position = point
            self.addChild(upNode)
        }
        
        let down_block_num = total_block - up_block_num - 6
        
        for ( var i = 0; i < down_block_num ; i++ ) {
            let downNode = BlockNode.makeBlock()
            let point_y : CGFloat = CGFloat(CommonConst.footerHeight) + downNode.half_height + downNode.height*CGFloat(i)
            let point = CGPointMake(CGRectGetMaxX(self.frame), point_y)
            downNode.position = point
            self.addChild(downNode)
        }
    }
    
    func makeAllBlock(interval: Int){
        // interval秒に１回　ブロックを出現
        if Int(_timeSinceStart)%interval != 0 {
            return
        }
        let total_block = Int(_stageHeight)/CommonConst.block_width
        
        for ( var i = 0; i < total_block ; i++ ) {
            let upNode = BlockNode.makeBlock()
            let point_y : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight) - upNode.half_height - upNode.height*CGFloat(i)
            let point = CGPointMake(CGRectGetMaxX(self.frame), point_y)
            upNode.position = point
            self.addChild(upNode)
        }
    }
    
    override func setBattleTap(){
        var frequency = 8
        if _equip == "juryoku" {
            frequency = 5
        }
        _tapCount += 1
        // 8回タップ毎に１回ファイアボールを発動
        if(_tapCount%frequency == 0){
            setFireBall(_kappa.position)
        }
    }
    
    
    override func isCritical() -> Bool{
        return CommonUtil.rnd(100) < _luck || _equip == "katana"
    }
    
    func setFireBall(location: CGPoint){
        let fire = FireNode.make(location)
        self.addChild(fire)
        fire.physicsBody?.velocity = CGVectorMake(CGFloat(_fireSpeed), 0)
    }
    
    func getCoin(val : Int){
        _gold += val
        showMoney()
        coinBGM()
    }
    
    // 敵と衝突時
    func hitEnemy(heroBody: SKPhysicsBody, enemyBody: SKPhysicsBody){
        makeSpark(heroBody.node?.position)
        let damage = enemyBody.node?.userData?.valueForKey("str") as! Int
        damaged(damage, point: (heroBody.node?.position)!, color: UIColor.redColor())
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
        if firstBody.node == nil || secondBody.node == nil {
            return
        }
        
        // 主人公の衝突判定
        if (firstBody.categoryBitMask & heroCategory != 0 ) {
            if secondBody.categoryBitMask & enemyCategory != 0 {
                hitEnemy(firstBody, enemyBody: secondBody)
                return
            } else if secondBody.categoryBitMask & itemCategory != 0 {
                getApple(secondBody)
                return
            } else if secondBody.categoryBitMask & coinCategory != 0 {
                var val = secondBody.node?.userData?.objectForKey("gold") as! Int
                if _danjon_type == "hard" {
                    val = val * 2
                } else if _danjon_type == "special" {
                    val = val*3
                }
                getCoin(val)
                displayDamage(val, point: secondBody.node!.position, color: UIColor.yellowColor())
                secondBody.node?.removeFromParent()
                return
            } else if secondBody.categoryBitMask & blockCategory != 0 {
                makeSpark(firstBody.node?.position)
                let damage = 1
                damaged(damage, point: firstBody.node!.position, color: UIColor.redColor())
                secondBody.node?.removeFromParent()
                return
            } else if secondBody.categoryBitMask & downWorldCategory != 0 {
                hitDownWorld(firstBody)
            } else if secondBody.categoryBitMask & wallCategory != 0 {
                if _equip != "kabuto" {
                    makeSpark(firstBody.node?.position)
                    let damage = 1
                    damaged(damage, point: firstBody.node!.position, color: UIColor.redColor())
                }
            }
        }

        // 敵の衝突判定
        if (firstBody.categoryBitMask & enemyCategory != 0 ) {
            if secondBody.categoryBitMask & worldCategory != 0 {
                firstBody.node?.removeFromParent()
            } else if secondBody.categoryBitMask & fireCategory != 0 {
                makeSpark(firstBody.node?.position)
                
                displayDamage(_int, point: firstBody.node!.position, color: _textColor)
                hitFire(firstBody, fireBody: secondBody)
            } else if secondBody.categoryBitMask & swordCategory != 0 {
                hitSword(firstBody,swordBody: secondBody)
            }
        }
        
        // 炎の衝突判定
        if (firstBody.categoryBitMask & fireCategory != 0 ) {
            if secondBody.categoryBitMask & horizonWorldCategory != 0 {
                firstBody.node?.removeFromParent()
            }
        }
        
        // 剣の衝突判定
        if (firstBody.categoryBitMask & swordCategory != 0 ) {
            if secondBody.categoryBitMask & worldCategory != 0 {
                firstBody.node?.removeFromParent()
            } else if secondBody.categoryBitMask & blockCategory != 0 {
                makeSpark(firstBody.node?.position)
                attackBGM()
                if _break_block_flag {
                    secondBody.node?.removeFromParent()
                    if (_equip == "golden") {
                        makeCoin(1+CommonUtil.rnd(_luck), location: secondBody.node?.position)
                    } else {
                        makeCoin(1, location: secondBody.node?.position)
                    }
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
        // ブロック
        if (firstBody.categoryBitMask & blockCategory != 0 ) {
            if secondBody.categoryBitMask & leftHorizonWorldCategory != 0 {
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

    func hitDownWorld(firstBody : SKPhysicsBody){
    }
    
    func makeCoin(gold : Int, location: CGPoint?){
        let coin : CoinNode = CoinNode.makeCoin(gold)
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
            }
        } else {
            enemyHP -= _int
            if enemyNode.name == "boss" {
                _bossHP -= _int
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

        var enemyHP : Int      = enemyNode.userData?.valueForKey("hp") as! Int
        let enemyDef : Int     = enemyNode.userData?.valueForKey("def") as! Int
        let enemyName : String = enemyNode.userData?.valueForKey("name") as! String
        var damage : Int = 1
        
        if swordBody.node?.name == "critical" {
            makeCriticalSpark(swordBody.node?.position)
            damage = _str - enemyDef/2 + CommonUtil.rnd(_luck/2)
            if damage <= 1 {
                damage = 2
            }
        } else {
            makeSpark(swordBody.node?.position)
            if _equip == "bringer" {
                damage = 5
            } else {
                damage = CommonUtil.rnd(_str - enemyDef) + 1
            }
        }
        if(damage <= 0) {
            damage = 1
        }
        if(_equip == "shine") {
            if(damage < _highScore){
                damage = _highScore
            }
        }
        
        enemyHP -= damage
        if enemyNode.name == "boss" {
            _bossHP -= damage
            showBossName()
        }
        displayDamage(damage, point: firstBody.node!.position, color: _textColor)
        if(enemyHP <= 0){
            beatEnemy(enemyNode)
        } else {
            enemyNode.userData?.setValue(enemyHP, forKey: "hp")
        }
        setEnemyLife(enemyName, life: enemyHP)
        swordBody.node?.removeFromParent()
    }
    
    // 敵を撃破
    func beatEnemy(enemyNode: SKSpriteNode){
        let gold = enemyNode.userData?.valueForKey("gold") as! Int
        makeCoin(gold, location: CGPointMake(enemyNode.position.x, enemyNode.position.y))

        // ゾンビ状態ならば HP を回復
        // FIXME レベルが上がるとHP吸収量が上がる？
        if _zombi_flag {
            _hp += 1
            changeLifeLabel()
            changeLifeBar()
        }
        
        if enemyNode.name == "boss" {
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
    
    func setGameEndFlag(){
        _game_end_flag = true
        stageClear()
    }

    // 敵と衝突し、ダメージを受ける
    // HPが0以下になったらゲームオーバー
    func damaged(value: Int, point: CGPoint, color : UIColor){
        damagedBGM()
        var damage : Int = 1
        if(_danjon_type == "normal") {
            damage = value
        } else if _danjon_type == "hard" {
            damage = value * 2
        } else if _danjon_type == "special" {
            damage = value * 3
        }
        if _job == "P" && CommonUtil.rnd(100) < _luck {
            damage = 1
        }
        
        _hp -= damage
        changeLifeBar()
        changeLifeLabel()
        if(_hp <= 0 && _boss_beat_flag != true){
            _game_end_flag = true
            goGameOver()
        }
        displayDamage(damage, point: point, color: color)

    }
    
    // ダメージを数字で表示
    func displayDamage(value: Int, point: CGPoint, color: UIColor){
        let location = CGPointMake(point.x, point.y + 50.0)
        let label = SKLabelNode(fontNamed: CommonConst.font_regular)
        label.text = "\(value)"
        label.position = location
        label.fontColor = color
        label.fontSize = 25
        label.zPosition = 90
        self.addChild(label)
        
        let fade : SKAction = SKAction.fadeOutWithDuration(4)
        label.runAction(fade)
    }
    

    // HPに変化があったのでライフバーを変更
    func changeLifeBar(){
        let life_bar : SKSpriteNode? = childNodeWithName("footer_status")?
            .childNodeWithName("life_bar") as? SKSpriteNode
        var width: Double = Double(_hp)/Double(_maxhp) * Double(_lifeBarWidth)
        if (width <= 0) {
            width = 1
        }
        life_bar!.size = CGSizeMake(CGFloat(width), CGFloat(CommonConst.lifeBarHeight))
    }

    // HPに変化があったのでライフバーを変更
    func changeLifeLabel(){
        if _hp <= 0 {
            _hp = 0
        } else if _hp > _maxhp {
            _hp = _maxhp
        }
        
        let life_label : SKLabelNode? = childNodeWithName("footer_status")?
            .childNodeWithName("hp_label") as? SKLabelNode
        life_label!.text = "HP : \(_hp) / \(_maxhp)"
    }
    
    // 画面外にいるキャラを削除
    func worldEnd(){
        self.enumerateChildNodesWithName("enemy", usingBlock: {
            (node: SKNode, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            if node.position.x < 0 {
                node.removeFromParent()
            }
        })
        self.enumerateChildNodesWithName("fire", usingBlock: {
            (node: SKNode, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            if node.position.x < 0 {
                node.removeFromParent()
            } else if node.position.x > self.frame.size.width {
                node.removeFromParent()
            }
        })
    }
    
    func showDistance(){
        let distanceLabel : SKLabelNode? = childNodeWithName("distance") as? SKLabelNode
        let distance = CommonUtil.displayDistance(_distance)
        distanceLabel?.text = "残り \(distance)"
        distanceLabel?.fontColor = _textColor
//        distanceLabel?.zPosition = 3
    }
    
    func showMoney(){
        let goldLabel : SKLabelNode? = childNodeWithName("header_status")?.childNodeWithName("gold_label") as? SKLabelNode
        let gold = CommonUtil.displayMoney(_gold)
        goldLabel?.text = gold
    }
    

    func showBossName(){
        let distanceLabel : SKLabelNode? = childNodeWithName("distance") as? SKLabelNode
        distanceLabel?.text = "\(_bossName)を倒せ"
        distanceLabel?.zPosition = 3
    }
    
    func beatBoss(){
        let distanceLabel : SKLabelNode? = childNodeWithName("distance") as? SKLabelNode
        distanceLabel?.text = "ボス撃破!!!!"
        distanceLabel?.fontColor = _textColor
        distanceLabel?.zPosition = 3
    }

    func stageClear(){
        goGameClearScene()
    }
    
    // ゲームオーバー画面へ
    func goGameOver(){
        stopBGM()
        let secondScene = GameOverScene(size: self.frame.size)
        let tr = SKTransition.fadeWithColor(_textColor, duration: 4)
        changeScene(secondScene, tr: tr)
    }
    
    func goGameClearScene() {
        stopBGM()
        dataSave()
        let secondScene = GameClearScene(size: self.frame.size)
        let tr = SKTransition.fadeWithColor(_textColor, duration: 4)
        changeScene(secondScene, tr: tr)
    }
    
    // 画面遷移時、データを保存する
    func dataSave(){
        CommonData.setData("gold", value: _gold)
    }
    
    // 魔王専用の動き。ワープ。
    func Maoworp(){
        let mao : MaoNode? = childNodeWithName("boss") as? MaoNode
        if mao == nil {
            return
        }
        
        // ワープ時に敵を召喚
        for var i=0; i<10;i++ {
            makeGhost(100)
            
        }
        makeSkelton(100)
        makeMiira(100)
        
        let height: Int = CommonUtil.rnd(Int(_stageHeight) - 40) + CommonConst.footerHeight
        let point_x : Int = CommonUtil.rnd(Int(CGRectGetMaxX(self.frame)-80)) + 40
        let point : CGPoint = CGPointMake(CGFloat(point_x), CGFloat(height))
        mao!.position = point
        
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("Maoworp"), userInfo: nil, repeats: false)
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
            
            if(CommonUtil.rnd(100) < 15) {
                    heal()
            }
        }
        _lastUpdateTimeInterval = currentTime
        
        // 距離の処理。目的地についたらボス登場
        _distance -= 1
        if _distance >= 0 {
            showDistance()
        }
        if(_distance <= 0 && _boss_flag == false){
            _boss_flag = true
            makeBoss(_danjon_type)
            showBossName()
        }
        worldEnd()
    }
    
    func heal(){
        if _job != "賢者" {
            return
        }
        _hp += 1
        changeLifeLabel()
        changeLifeBar()
    }
}