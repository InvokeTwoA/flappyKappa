// アイテム装備
import SpriteKit
class Equip2Scene: BaseScene {
    
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
        setWeapon("oretue", point_y: point_y2)
        setWeapon("soul", point_y: point_y3)
        setWeapon("juryoku", point_y: point_y4)
        setWeapon("shine", point_y: point_y5)
        setCenterButton("装備を外す", key_name: "nothing", point_y: point_y6)
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
        } else if name == "nothing" {
            CommonData.setData("equip_weapon", value: "何もなし")
            let secondScene = Equip2Scene(size: self.frame.size)
            changeSceneWithoutTr(secondScene)
        
        } else if name == "hatena_oretue" {
            showAlert(WeaponSetting.getName("oretue"), text: WeaponSetting.getExplain("oretue"), ok_text: "なるほどねー")
        } else if name == "hatena_juryoku" {
            showAlert(WeaponSetting.getName("juryoku"), text: WeaponSetting.getExplain("juryoku"), ok_text: "へぇー")
        } else if name == "hatena_soul" {
            showAlert(WeaponSetting.getName("soul"), text: WeaponSetting.getExplain("soul"), ok_text: "ふむふむ")
        } else if name == "hatena_shine" {
            showAlert(WeaponSetting.getName("shine"), text: WeaponSetting.getExplain("shine"), ok_text: "すげえ")
        } else if name == "equip_oretue" {
            CommonData.setData("equip_weapon", value: "oretue")
            let secondScene = Equip2Scene(size: self.frame.size)
            changeSceneWithoutTr(secondScene)
        } else if name == "equip_soul" {
            CommonData.setData("equip_weapon", value: "soul")
            let secondScene = Equip2Scene(size: self.frame.size)
            changeSceneWithoutTr(secondScene)
        } else if name == "equip_juryoku" {
            CommonData.setData("equip_weapon", value: "juryoku")
            let secondScene = Equip2Scene(size: self.frame.size)
            changeSceneWithoutTr(secondScene)
        } else if name == "equip_shine" {
            CommonData.setData("equip_weapon", value: "shine")
            let secondScene = Equip2Scene(size: self.frame.size)
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