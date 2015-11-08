// アイテム装備
import SpriteKit
class EquipScene: BaseScene {
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.1,green:0.0,blue:0.1,alpha:1.0)
        setBaseSetting()
        setBackButton("戻る")
    
        let point_y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight*2)
        let point_y2 : CGFloat = point_y1 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y3 : CGFloat = point_y2 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y4 : CGFloat = point_y3 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y5 : CGFloat = point_y4 - CGFloat(CommonConst.textBlankHeight * 2)
        let point_y6 : CGFloat = point_y5 - CGFloat(CommonConst.textBlankHeight * 2)

        setCenterText("武器名をタップすれば装備します。", key_name: "explain", point_y: point_y1)
        let weapon_name = WeaponSetting.getName(_equip)
        setCenterText("現在の装備：\(weapon_name)", key_name: "equip", point_y: point_y2)
        setWeapon("long", point_y: point_y3)
        setWeapon("katana", point_y: point_y4)
        setWeapon("shoes", point_y: point_y5)

        setCenterButton("次ページへ", key_name: "next", point_y: point_y6)
    }
    
    func setWeapon(key_name: String, point_y: CGFloat){
        let weapon_label : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        weapon_label.position = CGPointMake(120, point_y)
        weapon_label.fontSize = CGFloat(CommonConst.font_size_normal)
        
        // 所持していたらアイテム名を表示。未所持だったら???を表示
        if CommonData.getDataByInt("weapon_\(key_name)") == 0 {
            weapon_label.text = "?????"
            self.addChild(weapon_label)
        } else {
            let weapon_name = WeaponSetting.getName(key_name)
            
            // 装備中かどうか
            if _equip != key_name {
                weapon_label.text = weapon_name
                weapon_label.name = "equip_\(key_name)"
            } else {
                weapon_label.text = "[装備]\(weapon_name)"
                weapon_label.name = "equip_off_\(key_name)"
            }
            self.addChild(weapon_label)
            
            // はてなを表示
            let hatena = SKSpriteNode(imageNamed: "hatena.gif")
            hatena.name = "hatena_\(key_name)"
            hatena.position = CGPointMake(weapon_label.position.x + CGFloat(weapon_label.frame.width/2) + 30, point_y + 10)
            self.addChild(hatena)
        }
    }
    
    
    
    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "back" {
            goGameSceneWithClose()
        } else if name == "next" {
            goNext()
        } else if name == "hatena_long" {
            showAlert(WeaponSetting.getName("long"), text: WeaponSetting.getExplain("long"), ok_text: "なるほどねー")
        } else if name == "hatena_katana" {
                showAlert(WeaponSetting.getName("katana"), text: WeaponSetting.getExplain("katana"), ok_text: "へぇー")
        } else if name == "hatena_shoes" {
            showAlert(WeaponSetting.getName("shoes"), text: WeaponSetting.getExplain("shoes"), ok_text: "ふむふむ")
        } else if name == "equip_long" {
            CommonData.setData("equip_weapon", value: "long")
            reloadScene()
        } else if name == "equip_katana" {
            CommonData.setData("equip_weapon", value: "katana")
            reloadScene()
        } else if name == "equip_shoes" {
            CommonData.setData("equip_weapon", value: "shoes")
            reloadScene()
        }
    }
    
    func reloadScene(){
        let secondScene = EquipScene(size: self.frame.size)
        let tr = SKTransition.flipHorizontalWithDuration(1)
        changeScene(secondScene, tr: tr)
    }
    
    func goNext(){
        let secondScene = Equip2Scene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    
    // ドアを閉じるモーションでゲーム画面へ
    func goGameSceneWithClose(){
        let secondScene = GameScene(size: self.frame.size)
        let tr = SKTransition.doorsCloseHorizontalWithDuration(1)
        changeScene(secondScene, tr: tr)
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
}