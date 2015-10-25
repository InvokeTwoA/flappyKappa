// 街画面
import SpriteKit
class ShopWeaponScene: BaseScene {
    
    var _buy_name : String = "ぶひ"
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.0,green:0.5,blue:1.0,alpha:1.0)
        setBaseSetting()
        
        if CommonData.getDataByInt("buy_complete") == 1 {
            self.showAlert("おあがりよー！", text:"武器は装備しないと意味がないから気をつけな。", ok_text: "これで俺も最強だ！")
            CommonData.setData("buy_complete", value: 0)
        }
        
        let point_y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight*2)
        let point_y2 : CGFloat = point_y1 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y3 : CGFloat = point_y2 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y4 : CGFloat = point_y3 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y5 : CGFloat = point_y4 - CGFloat(CommonConst.textBlankHeight * 2)
        setWeapon("long",   point_y: point_y1)
        setWeapon("katana", point_y: point_y2)
        setWeapon("shoes",  point_y: point_y3)
        setWeapon("hammer", point_y: point_y4)
        setCenterButton("高級商品を見る", key_name: "next", point_y: point_y5)
        setBackButton("あばよ！")
    }
    
    func setWeapon(key_name: String, point_y: CGFloat){
        // 商品名を表示
        if CommonData.getDataByInt("weapon_\(key_name)") == 0 {
            setCenterText(WeaponSetting.getName(key_name), key_name: "buy_\(key_name)", point_y: point_y)
            
            var weapon_label :SKLabelNode? = childNodeWithName("buy_\(key_name)") as? SKLabelNode
            // はてなを表示
            var hatena = SKSpriteNode(imageNamed: "hatena.gif")
            hatena.name = "hatena_\(key_name)"
            hatena.position = CGPointMake(weapon_label!.position.x + CGFloat(weapon_label!.frame.width/2) + 30, point_y + 10)
            self.addChild(hatena)
        } else {
            setCenterText("売り切れ", key_name: "urikire", point_y: point_y)
        }
    }

    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "hatena_long" {
            showAlert(WeaponSetting.getName("long"), text: WeaponSetting.getExplain("long"), ok_text: "なるほどねー")
        } else if name == "hatena_katana" {
            showAlert(WeaponSetting.getName("katana"), text: WeaponSetting.getExplain("katana"), ok_text: "へぇー")
        } else if name == "hatena_shoes" {
            showAlert(WeaponSetting.getName("shoes"), text: WeaponSetting.getExplain("shoes"), ok_text: "そうなんだー")
        } else if name == "hatena_hammer" {
            showAlert(WeaponSetting.getName("hammer"), text: WeaponSetting.getExplain("hammer"), ok_text: "それは良い")
        } else if name == "buy_long" {
            _buy_name = "long"
            buyConfirm()
        } else if name == "buy_katana" {
            _buy_name = "katana"
            buyConfirm()
        } else if name == "buy_shoes" {
            _buy_name = "shoes"
            buyConfirm()
        } else if name == "buy_hammer" {
            _buy_name = "hammer"
            buyConfirm()
        } else if name == "next" {
            goNextScene()
        } else if name == "back" {
            goShopScene()
        }
    }
    
    func buyConfirm(){
        let name = WeaponSetting.getName(_buy_name)
        let cost = WeaponSetting.getCost(_buy_name)
        
        // お金が足りない場合はここで終了
        if _gold < cost {
            showAlert("お金が足りないぜ", text: "\(name)は\(cost)ゴールドだ。金を貯めて出直し的な", ok_text: "了解であります")
            return
        }
        
        let alert: UIAlertController = UIAlertController(title:"ご注文は\(name)ですか？",
            message: "\(cost)ゴールドだ。買ってくかい？",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let buyAction: UIAlertAction = UIAlertAction(title: "はい！",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                CommonData.setData(self._buy_name, value: 1)
                CommonData.minus("gold", value: WeaponSetting.getCost(self._buy_name))
                self.setMoney()
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
        let secondScene = ShopWeaponScene(size: self.frame.size)
        changeSceneWithoutTr(secondScene)
    }

    func goNextScene(){
        let secondScene = Shop2WeaponScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }

    
    func goShopScene(){
        let secondScene = ShopScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
}

