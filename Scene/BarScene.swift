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
        
        setButton("酔っぱらい冒険者", key_name: "yoi", point_y: point_y1)
        setButton("謎の男",         key_name: "zombi", point_y: point_y2)

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
            showAlert("[情報No.5]", text: "戦闘中は各操作をする毎に僅かだがゴールドが手に入るぜ。\n\nタップ：１ゴールド \n 右スワイプ：３ゴールド\n左スワイプ：２ゴールド", ok_text: "そうだったんだー。")
        default :
            showAlert("[情報No.1]", text: "酒だー。酒を持ってこーい。", ok_text: "関わらないでおこう")
        }
    }
    
    func talkZombi(){
        // Style Alert
        let alert: UIAlertController = UIAlertController(title:"謎の男",
            message: "ククク。禁断の力が欲しいか？ \n   所持金を全て差し出し、。\n\n\n所持金全てと引き換えにスキル[吸血]とスキル[アンデッド]が手に入ります。",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let buyAction: UIAlertAction = UIAlertAction(title: "力が……欲しい！",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                CommonData.setData("nickname", value: "ゾンビ")
                CommonData.setData("skill_zombi", value: 1)
                CommonData.setData("skill_blood", value: 1)
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
    
    func goShopScene(){
        let secondScene = ShopScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
}

