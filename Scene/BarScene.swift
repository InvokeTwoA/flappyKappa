// 酒場の画面
import SpriteKit
class BarScene: BaseScene {
    
    var _buy_name : String = "ぶひ"
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.0,green:0.5,blue:1.0,alpha:1.0)
        setHeader()
        setMoney()
        
        let point_y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight*2)
        let point_y2 : CGFloat = point_y1 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y3 : CGFloat = point_y2 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y4 : CGFloat = point_y3 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y5 : CGFloat = point_y4 - CGFloat(CommonConst.textBlankHeight*2)

        
        
        setButton("酔っぱらい冒険者", key_name: "yoi",   point_y: point_y1)
        setButton("謎の男",         key_name: "zombi", point_y: point_y2)
        setButton("夜逃げ屋",       key_name: "yonige", point_y: point_y3)
        setButton("金持ち爺さん",    key_name: "kane", point_y: point_y4)
        setButton("神父",           key_name: "kami", point_y: point_y5)
        
        setBackButton("あばよ！")
    }
    
    // タッチイベント
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as? UITouch
        let location = touch!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        if (touchedNode.name != nil) {
            if touchedNode.name == "yoi" {
                talkYoi()
            } else if touchedNode.name == "zombi" {
                talkZombi()
            } else if touchedNode.name == "yonige" {
                talkYonige()
            } else if touchedNode.name == "kane" {
                talkKane()
            } else if touchedNode.name == "kami" {
                talkKami()
            } else if touchedNode.name == "back" {
                goShopScene()
            }
        }
    }
    
    func talkYoi(){
        let rnd : Int = CommonUtil.rnd(5)
        
        switch rnd {
        case 0:
            showAlert("[情報No.2]", text: "巨大猫には気をつけろ。\n\n画面の左側にいないと酷い目に合うぜ。", ok_text: "へー。")
        case 1:
            showAlert("[情報No.3]", text: "どこかのダンジョンに低確率で現れる金のネコ……。\n\n奴を倒せれば一攫千金も夢じゃないらしいぜ。", ok_text: "ほほーう。")
        case 2:
            showAlert("[情報No.4]", text: "アンデッド系やゴーレムは物理攻撃が殆ど通らないぜ。", ok_text: "ふむふむ。")
        case 3:
            showAlert("[情報No.5]", text: "死んだら能力は初期化される。でも買った装備や施設は引き継がれるんだ。", ok_text: "そうだったんだー。")
        default :
            showAlert("[情報No.1]", text: "酒だー。酒を持ってこーい。", ok_text: "関わらないでおこう")
        }
    }
    
    func talkZombi(){
        let lv =  CommonData.getDataByInt("lv")
        if(lv < 10){
            showAlert("謎の男", text: "「LVが低い人間は私と話す資格はない……」", ok_text: "お、おう。")
        } else {
            blood_plus()
        }
    }
        
    func blood_plus(){
        let alert: UIAlertController = UIAlertController(title:"謎の男",
            message: "ククク。禁断の力が欲しいか？ \n  とある代償と引き換えにスキル[吸血]とスキル[アンデッド]が手に入ります。",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let buyAction: UIAlertAction = UIAlertAction(title: "力が……欲しい！",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                CommonData.blood_plus()
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "関わらないでおこう。",
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.changeNickname("冷やかし", percent: 50)
        })
        alert.addAction(buyAction)
        alert.addAction(cancelAction)
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }

    
    func talkYonige(){
        let alert: UIAlertController = UIAlertController(title:"夜逃げ屋",
            message: "全財産を捨てて一からやり直さないか？ \n\n 所持金が0になり、LVが１になります。全ステータスが半減します。",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let yesAction: UIAlertAction = UIAlertAction(title: "一からやり直そう",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.changeNickname("文無し", percent: 20)
                self.changeNickname("フリーダム", percent: 10)
                CommonData.change_yonige_status()
                self.goGameScene()
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "冗談じゃねえ。",
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.changeNickname("常識", percent: 10)
        })
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    func talkKane(){
        let alert: UIAlertController = UIAlertController(title:"富豪の男",
            message: "君にお金をあげよう",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let yesAction: UIAlertAction = UIAlertAction(title: "やったー",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                CommonData.plus("gold", value: 1000)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "冗談じゃねえ。",
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.changeNickname("常識", percent: 10)
        })
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }

    func talkKami(){
        let alert: UIAlertController = UIAlertController(title:"夜逃げ屋",
            message: "全財産を捨てて一からやり直さないか？ \n\n 所持金が0になり、LVが１になります。全ステータスが半減します。",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let buyAction: UIAlertAction = UIAlertAction(title: "一からやり直そう",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.changeNickname("文無し", percent: 20)
                self.changeNickname("フリーダム", percent: 10)
                CommonData.change_yonige_status()
                self.goGameScene()
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "冗談じゃねえ。",
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.changeNickname("常識", percent: 10)
        })
        alert.addAction(buyAction)
        alert.addAction(cancelAction)
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    func goShopScene(){
        let secondScene = ShopScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    func goGameScene(){
        let secondScene = GameScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
}

