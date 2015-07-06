// 街画面
import SpriteKit
class ShopWeaponScene: BaseScene {
    
    var _buy_name : String = "ぶひ"
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.0,green:0.5,blue:1.0,alpha:1.0)
        setHeader()
        setMoney()

        if CommonData.getDataByInt("buy_complete") == 1 {
            self.showAlert(WeaponSetting.getName("おあがりよー！"), text:"大事に使ってくれよ。", ok_text: "これで俺も最強だ！")
            CommonData.setData("buy_complete", value: 0)
        }
        
        let point_y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight*2)
        setWeapon("long", point_y: point_y1)
        setBackButton("あばよ！")
    }
    
    func setWeapon(key_name: String, point_y: CGFloat){

        // 商品名を表示
        var weapon_label : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        weapon_label.position = CGPointMake(100, point_y)
        weapon_label.fontSize = CGFloat(CommonConst.font_size_normal)
        weapon_label.text = WeaponSetting.getName(key_name)
        self.addChild(weapon_label)
        
        // はてなを表示
        var hatena = SKSpriteNode(imageNamed: "hatena.gif")
        hatena.name = "hatena_\(key_name)"
        hatena.position = CGPointMake(weapon_label.position.x + CGFloat(weapon_label.frame.width/2) + 30, point_y + 10)
        self.addChild(hatena)
        
        // 購入ボタンを表示
        let point = CGPointMake(hatena.position.x + 70, point_y + 10)
        if CommonData.getDataByInt("weapon_\(key_name)") == 0 {
            let gold = CommonData.getDataByInt("gold")
            if gold >= WeaponSetting.getCost(key_name) {
                var buyButton = CommonUI.normalButton("買う", name: "buy_\(key_name)", point: point)
                self.addChild(buyButton)
            } else {
                var label : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
                label.position = point
                label.fontSize = CGFloat(CommonConst.font_size_normal)
                label.text = "買えぬ"
                self.addChild(label)
            }
        } else {
            var label : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
            label.position = point
            label.fontSize = CGFloat(CommonConst.font_size_normal)
            label.text = "売り切れ"
            self.addChild(label)
        }
    }

    // タッチイベント
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as? UITouch
        let location = touch!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        if (touchedNode.name != nil) {
            if touchedNode.name == "hatena_long" {
                showAlert(WeaponSetting.getName("long"), text: WeaponSetting.getExplain("long"), ok_text: "なるほどねー")
                CommonData.setData("weapon_long", value: 1)
            } else if touchedNode.name == "buy_long" {
                _buy_name = "long"
                buyConfirm()
            } else if touchedNode.name == "back" {
                goShopScene()
            }
        }
    }
    
    func buyConfirm(){
        // Style Alert
        let alert: UIAlertController = UIAlertController(title:"お客さん、良いものに目をつけたね",
            message: "買ってくかい？",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let buyAction: UIAlertAction = UIAlertAction(title: "はい！",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                CommonData.setData(self._buy_name, value: 1)
                CommonData.plus("gold", value: -1*WeaponSetting.getCost(self._buy_name))
                CommonData.setData("buy_complete", value: 1)
                CommonData.setData("weapon_\(self._buy_name)", value: 1)
                self.reloadScene()
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "いらん",
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.changeNickname("冷やかし", percent: 50)
        })
        
        alert.addAction(buyAction)
        alert.addAction(cancelAction)
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }

    func reloadScene(){
        print("reload")
        let secondScene = ShopWeaponScene(size: self.frame.size)
        changeSceneWithoutTr(secondScene)
    }
    
    func goShopScene(){
        let secondScene = ShopScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
}

