// 全てのSceneの親クラス
// 共通処理などはここに記述
import Foundation
import SpriteKit
import AVFoundation

class BaseScene: SKScene, NADViewDelegate, SKPhysicsContactDelegate {
    var _gold : Int = 0
    var _nadView: NADView!
    
    // 各種ステータス
    var _agi : Int     = CommonData.getDataByInt("agi")
    var _luck : Int    = CommonData.getDataByInt("luck")
    var _equip :String = CommonData.getDataByString("equip_weapon")
    var _job :String   = CommonData.getDataByString("job")
    
    var _jump : CGFloat = 400
    var _swordSpeed : NSTimeInterval = CommonConst.swordNormalSpeed
    
    var _day : Int = CommonData.getDataByInt("day")
    var _nickname : String = CommonData.getDataByString("nickname")
    
    var _danjon_type :String = CommonData.getDataByString("danjon_type")
    
    // お金の初期値を設定
    func setMoney(){
        _gold = CommonData.getDataByInt("gold")
    }
    
    func setBaseSetting(){
        self.backgroundColor = UIColor.blackColor()
        setWorldPhysic()
        setupSwipeGestures()
        setHeader()
        setKappa()
        setSlimeDemo()
        setHorizonWorld()
        setMoney()
        setAgi()
    }
    
    func setHeader(){
        let point : CGPoint = CGPoint(x:CGRectGetMidX(frame), y: CGRectGetMaxY(frame) - CGFloat(CommonConst.headerHeight)/2)
        let size : CGSize = CGSizeMake(CGRectGetMaxX(frame), CGFloat(CommonConst.headerHeight))
        let color : UIColor = UIColor(red:0.2,green:0.2,blue:0.2,alpha:1.0)
        
        var background : SKSpriteNode = SKSpriteNode(color: color, size: size)
        background.position = point
        background.zPosition = 90
        background.name = "header_status"
        background.physicsBody = CommonUI.setWorldPhysic(size)

        var rnd_text : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        rnd_text.text = CommonUtil.randomHint()
        rnd_text.fontSize = 18
        rnd_text.position = CGPointMake(0, 20)
        rnd_text.fontColor = UIColor.whiteColor()
        rnd_text.name = "rnd_text"
        background.addChild(rnd_text)
        
        // 異名を表示
        var name : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        name.text = CommonUI.displayName()
        name.fontSize = 18
        name.position = CGPointMake(0, -15)
        name.fontColor = UIColor.whiteColor()
        name.name = "name_label"
        background.addChild(name)

        // 所持金を表示
        var gold : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        var gold_value : Int = CommonData.getDataByInt("gold")
        
        gold.text = CommonUtil.displayMoney(gold_value)
        gold.fontSize = 18
        gold.position = CGPointMake(0, -45)
        gold.fontColor = UIColor.whiteColor()
        gold.name = "gold_label"
        background.addChild(gold)
        
        self.addChild(background)

        let adTime : NSTimeInterval = CommonData.getDataByNSTimeInterval("adTime")
        if adTime != 0.0 {
            NSTimer.scheduledTimerWithTimeInterval(adTime, target: self, selector: Selector("showAd"), userInfo: nil, repeats: false)
        }
    }
    
    func showAd() {
        if(_nadView != nil){
            print("ad already exist. \n")
            return
        }

        // NADViewクラスを生成
        _nadView = NADView(frame: CGRect(x: 0, y: 0, width: 320, height: CommonConst.adHeight))

        // 広告枠のapikey/spotidを設定(必須)
        _nadView.setNendID(CommonConst.adKey, spotID: CommonConst.adSpot)
        
        // nadView.isOutputLog = false
        _nadView.delegate = self
        _nadView.load()
        self.view?.addSubview(_nadView)
    }
    func removeAd(){
        if(_nadView != nil){
            _nadView.removeFromSuperview()
            _nadView.delegate = nil
            _nadView = nil
        } else {
            print("already ad removed. return \n")
        }
    }
    
    func dayPast(){
        CommonData.dayPast()
    }
    
    func showAlert(title_text : String, text : String, ok_text : String){
        let alert = CommonUI.normalAlert(title_text, message: text, okMessage: ok_text)
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    func setWorldPhysic(){
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVectorMake(0, CGFloat(-1 * CommonConst.gravityValue))
        self.physicsBody?.categoryBitMask = worldCategory
    }
    
    // カッパを描画
    func setKappa() {
        var kappa : KappaNode;
        if _equip == "soul" {
            kappa = KappaNode.makeBigKappa()
            kappa.setBigPhysic()
        } else {
            kappa = KappaNode.makeKappa()
            kappa.setPhysic()
        }
        let point : CGPoint = CGPoint(x:CGRectGetMinX(self.frame) + 50, y:CGRectGetMidY(self.frame))
        kappa.position = point
        
        self.addChild(kappa)
        
        // 地面も描画
        let point2 : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y: CGRectGetMinY(self.frame))
        let size : CGSize = CGSizeMake(CGRectGetMaxX(self.frame), 1.0)
        var ground : SKSpriteNode = SKSpriteNode(color: UIColor.grayColor(), size: size)
        ground.position = point2
        ground.zPosition = 100
        ground.physicsBody = CommonUI.setWorldPhysic(size)
        self.addChild(ground)
    }
    
    func setGhostDemo(point : CGPoint){
        var chara = GhostNode.makeDemo()
        chara.position = point
        self.addChild(chara)
    }
    
    func setAgi(){
        if _equip == "shoes" {
            _agi = CommonConst.agi_max
        }
    }
    
    func kappaJump(){
        let jump : CGFloat = CGFloat(400+_agi)
        
        // カッパを飛ばす
        var kappa : KappaNode? = childNodeWithName("kappa") as? KappaNode
        kappa?.physicsBody?.velocity = CGVectorMake(0, jump)
    }

    // 右と左の画面は時に薄い壁を設定
    func setHorizonWorld(){
        let point : CGPoint = CGPoint(x:CGRectGetMinX(frame), y: CGRectGetMidY(self.frame))
        let size : CGSize = CGSizeMake(1, self.frame.height)
        let physic = SKPhysicsBody(rectangleOfSize: size)
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.dynamic = false
        physic.categoryBitMask = horizonWorldCategory
        var background : SKSpriteNode = SKSpriteNode(color: UIColor.blackColor(), size: size)
        background.position = point
        background.zPosition = 100
        background.physicsBody = physic
        self.addChild(background)
        
        let point2 : CGPoint = CGPoint(x:CGRectGetMaxX(frame), y: CGRectGetMidY(self.frame))
        var background2 : SKSpriteNode = SKSpriteNode(color: UIColor.blackColor(), size: size)
        background2.position = point2
        background2.zPosition = 100
        let physic2 = SKPhysicsBody(rectangleOfSize: size)
        physic2.affectedByGravity = false
        physic2.allowsRotation = false
        physic2.dynamic = false
        physic2.categoryBitMask = horizonWorldCategory
        
        background2.physicsBody = physic2
        
        self.addChild(background2)
    }
    
    // スワイプ処理の設定
    func setupSwipeGestures() {
        let gestureToRight: UISwipeGestureRecognizer  = UISwipeGestureRecognizer(target: self, action: Selector("swipeRight:"))
        gestureToRight.direction = .Right
        self.view?.addGestureRecognizer(gestureToRight)
        
        let gestureToLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipeLeft:"))
        gestureToLeft.direction = .Left
        self.view?.addGestureRecognizer(gestureToLeft)
    }
    
    func swipeRight(gesture: UISwipeGestureRecognizer){
        var kappa : KappaNode? = childNodeWithName("kappa") as? KappaNode
        kappa?.physicsBody?.applyImpulse(CGVectorMake(CGFloat(_agi), 0))
    }
    
    func swipeLeft(gesture: UISwipeGestureRecognizer){
        var kappa : KappaNode? = childNodeWithName("kappa") as? KappaNode
        kappa?.physicsBody?.applyImpulse(CGVectorMake(CGFloat(-1*_agi), 0))
    }
    
    // 画面遷移前など、所持金を記録
    func saveMoney(){
        CommonData.setData("gold", value: _gold)
    }
    
    func setButton(display_name: String, key_name: String, point_y : CGFloat){
        let point : CGPoint = CGPoint(x:CGRectGetMinX(self.frame) + 100, y:point_y)
        let startButton: SKSpriteNode = CommonUI.normalButton(display_name, name: key_name, point: point)
        self.addChild(startButton)
    }
    
    func setCenterButton(display_name: String, key_name: String, point_y : CGFloat){
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:point_y)
        let startButton: SKSpriteNode = CommonUI.normalButton(display_name, name: key_name, point: point)
        self.addChild(startButton)
    }
    
    func setText(text: String, key_name: String, point_y : CGFloat){
        let point : CGPoint = CGPoint(x:CGRectGetMinX(self.frame) + 100, y:point_y)
        let startButton: SKLabelNode = CommonUI.normalText(text, name: key_name, point: point)
        self.addChild(startButton)
    }
    
    func setCenterText(text: String, key_name: String, point_y : CGFloat){
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:point_y)
        let startButton: SKLabelNode = CommonUI.normalText(text, name: key_name, point: point)
        self.addChild(startButton)
    }

    func setPicture(path : String){
        var kappa : SKSpriteNode = SKSpriteNode(imageNamed: path)
        let point : CGPoint = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight * 2 + 80))
        kappa.position = point
        self.addChild(kappa)
    }
    
    // 確率で異名を変更
    func changeNickname(nickname :String, percent : Int){
        if CommonUtil.rnd(100) < percent {
            CommonData.setData("nickname", value: nickname)
        }
    }
    
    // 戻るボタンを画面下に設置
    func setBackButton(text : String) {
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMinY(self.frame) + CGFloat( CommonConst.textBlankHeight))
        let startButton: SKSpriteNode = CommonUI.normalButton(text, name: "back", point: point)
        self.addChild(startButton)
    }
    
    /* 以下、画面遷移 */
    func changeScene(secondScene: SKScene, tr : SKTransition){
        // まだ広告が出現していないのでscene移動させない（広告の二重呼びを防止）
        if(_nadView == nil){
            print("Ad not exist return \n")
            return
        }
        removeAd()
        saveMoney()
        CommonData.setData("adTime", value: 0.5)
        let skView = self.view! as SKView
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        skView.presentScene(secondScene, transition: tr)
    }
    
    func changeSceneWithLongDuration(secondScene: SKScene, tr : SKTransition, duration : NSTimeInterval = 1.0){
        // まだ広告が出現していないのでscene移動させない（広告の二重呼びを防止）
        if(_nadView == nil){
            print("Ad not exist return \n")
            return
        }
        removeAd()
        saveMoney()
        CommonData.setData("adTime", value: duration)
        let skView = self.view! as SKView
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        skView.presentScene(secondScene, transition: tr)
    }
    
    func changeSceneWithoutTr(secondScene: SKScene){
        // まだ広告が出現していないのでscene移動させない（広告の二重呼びを防止）
        if(_nadView == nil){
            print("Ad not exist return \n")
            return
        }

//        CommonData.setData("adTime", value: 0.0)
        removeAd()
        saveMoney()
        let skView = self.view! as SKView
        CommonData.setData("adTime", value: 0.1)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        skView.presentScene(secondScene)
    }
    
    
    func setSlimeDemo(){
        var slime = SlimeNode.makeDemo()
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame) + 10, y:CGRectGetMidY(self.frame) + 50)
        slime.position = point
        
        self.addChild(slime)
    }
    
    
    // タッチイベント
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as? UITouch
        let location = touch!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        if (touchedNode.name != nil) {
            checkTochEvent(touchedNode.name!)
        }
        kappaJump()
        setBattleTap()
        setSword(location)
    }
    
    func setBattleTap(){
        return
    }
    
    // 剣を作成。
    func setSword(to: CGPoint){
        var kappa : KappaNode? = childNodeWithName("kappa") as? KappaNode
        let from = kappa!.position
        var sword : SwordNode = SwordNode.makeSword()
        if isCritical() {
            sword.physicsBody?.allowsRotation = true
            sword.physicsBody?.angularDamping = 0.0
            sword.physicsBody?.angularVelocity = 9.0
            sword.name = "critical"
        }
        sword.position = from
        self.addChild(sword)
        var action : SKAction = SKAction.moveTo(to, duration: _swordSpeed)
        sword.runAction(action, completion:
            { sword.removeFromParent() }
        )
    }
    
    func isCritical() -> Bool{
        return CommonUtil.rnd(100) < _luck
    }
    
    func checkTochEvent(name :String){
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody, secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 剣の衝突判定
        if (firstBody.categoryBitMask & swordCategory != 0 ) {
            if secondBody.categoryBitMask & worldCategory != 0 {
                firstBody.node?.removeFromParent()
            } else if secondBody.categoryBitMask & blockCategory != 0 {
                makeSpark(firstBody.node?.position)
                firstBody.node?.removeFromParent()
            }
        }
    }
    
    // 衝突時など、火花を出す
    func makeSpark(location: CGPoint?){
        let particle = SparkEmitterNode.makeSpark("Spark")
        particle.position = location!
        particle.zPosition = 1
        self.addChild(particle)
    }

    
}