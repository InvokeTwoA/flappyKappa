// アイテム装備
import SpriteKit
class Equip3Scene: BaseScene {
    
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
        
        setWeapon("habel", point_y: point_y1)
        setWeapon("kabuto", point_y: point_y2)
        setWeapon("golden", point_y: point_y3)
        setWeapon("bringer", point_y: point_y4)
    }
    
    func setWeapon(key_name: String, point_y: CGFloat){
        var weapon_label : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
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
            var hatena = SKSpriteNode(imageNamed: "hatena.gif")
            hatena.name = "hatena_\(key_name)"
            hatena.position = CGPointMake(weapon_label.position.x + CGFloat(weapon_label.frame.width/2) + 30, point_y + 10)
            self.addChild(hatena)
        }
    }
    
    
    
    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "back" {
            goGameSceneWithClose()
        } else if name == "hatena_habel" {
            showAlert(WeaponSetting.getName("habel"), text: WeaponSetting.getExplain("habel"), ok_text: "なるほどねー")
        } else if name == "hatena_kabuto" {
            showAlert(WeaponSetting.getName("juryoku"), text: WeaponSetting.getExplain("kabuto"), ok_text: "へぇー")
        } else if name == "hatena_golden" {
            showAlert(WeaponSetting.getName("golden"), text: WeaponSetting.getExplain("golden"), ok_text: "ふむふむ")
        } else if name == "hatena_bringer" {
            showAlert(WeaponSetting.getName("bringer"), text: WeaponSetting.getExplain("bringer"), ok_text: "すげえ")
        } else if name == "equip_habel" {
            CommonData.setData("equip_weapon", value: "habel")
            let secondScene = Equip3Scene(size: self.frame.size)
            changeSceneWithoutTr(secondScene)
        } else if name == "equip_kabuto" {
            CommonData.setData("equip_weapon", value: "kabuto")
            let secondScene = Equip3Scene(size: self.frame.size)
            changeSceneWithoutTr(secondScene)
        } else if name == "equip_golden" {
            CommonData.setData("equip_weapon", value: "golden")
            let secondScene = Equip3Scene(size: self.frame.size)
            changeSceneWithoutTr(secondScene)
        } else if name == "equip_bringer" {
            CommonData.setData("equip_weapon", value: "bringer")
            let secondScene = Equip3Scene(size: self.frame.size)
            changeSceneWithoutTr(secondScene)
        }
    }
    
    // ドアを閉じるモーションでゲーム画面へ
    func goGameSceneWithClose(){
        let secondScene = GameScene(size: self.frame.size)
        let tr = SKTransition.doorsCloseHorizontalWithDuration(1)
        changeSceneWithLongDuration(secondScene, tr: tr)
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
}