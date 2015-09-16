// 全てのSceneの親クラス
// 共通処理などはここに記述
import Foundation
import SpriteKit

class BaseScene: SKScene, NADViewDelegate {
    var _gold : Int = 0
    var _income : Int = 0
    var _nadView: NADView!
    
    // お金の初期値を設定
    func setMoney(){
        _gold = CommonData.getData("gold") as! Int
        _income = CommonData.getData("income") as! Int
    }
    
    func setHeader(){
        let point : CGPoint = CGPoint(x:CGRectGetMidX(frame), y: CGRectGetMaxY(frame) - CGFloat(CommonConst.headerHeight)/2)
        let size : CGSize = CGSizeMake(CGRectGetMaxX(frame), CGFloat(CommonConst.headerHeight))
        let color : UIColor = UIColor(red:1.0,green:0.75,blue:0.8,alpha:1.0)
        var background : SKSpriteNode = SKSpriteNode(color: color, size: size)
        background.position = point
        background.zPosition = 90
        background.name = "header_status"
        background.physicsBody = CommonUI.setWorldPhysic(size)

        var rnd_text : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        rnd_text.text = "カッパ神ばんざーい"
        rnd_text.fontSize = 18
        rnd_text.position = CGPointMake(0, 20)
        rnd_text.fontColor = UIColor.blackColor()
        rnd_text.name = "rnd_text"
        background.addChild(rnd_text)

        // 異名を表示
        var name : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        name.text = CommonUI.displayName()
        name.fontSize = 18
        name.position = CGPointMake(0, -15)
        name.fontColor = UIColor.blackColor()
        name.name = "name_label"
        background.addChild(name)

        // 所持金を表示
        var gold : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        var gold_value : Int = CommonData.getDataByInt("gold")
        
        print("gold=\(gold_value) \n")
        
        gold.text = CommonUtil.displayMoney(gold_value)
        gold.fontSize = 18
        gold.position = CGPointMake(0, -45)
        gold.fontColor = UIColor.blackColor()
        gold.name = "gold_label"
        background.addChild(gold)
        
        self.addChild(background)

        let adTime : NSTimeInterval = CommonData.getData("adTime") as! NSTimeInterval
//        if adTime != 0.0 {
            NSTimer.scheduledTimerWithTimeInterval(adTime, target: self, selector: Selector("showAd"), userInfo: nil, repeats: false)
//        }
    }
    
    func showAd() {
        if(_nadView != nil){
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
        }
    }
    
    func showAlert(title_text : String, text : String, ok_text : String){
        let alert = CommonUI.normalAlert(title_text, message: text, okMessage: ok_text)
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
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
    
    func setText(text: String, key_name: String, point_y : CGFloat){
        let point : CGPoint = CGPoint(x:CGRectGetMinX(self.frame) + 100, y:point_y)
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
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMinY(self.frame) + CGFloat( CommonConst.textBlankHeight*2))
        let startButton: SKSpriteNode = CommonUI.normalButton(text, name: "back", point: point)
        self.addChild(startButton)
    }
    
    /* 以下、画面遷移 */
    func changeScene(secondScene: SKScene, tr : SKTransition){
        // まだ広告が出現していないのでscene移動させない（広告の二重呼びを防止）
        if(_nadView == nil){
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
            return
        }

//        CommonData.setData("adTime", value: 0.0)
        
        saveMoney()
        let skView = self.view! as SKView
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        skView.presentScene(secondScene)
    }
}