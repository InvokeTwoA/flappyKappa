import Foundation
import SpriteKit

/*
* ゲームの基本画面
*/
class SettingScene: BaseScene {
    
    override func didMoveToView(view: SKView) {
        setBaseSetting()
        
        let point_y1 = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight)
        let point_y2 = point_y1 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y3 = point_y2 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y4 = point_y3 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y5 = point_y4 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y6 = point_y5 - CGFloat(CommonConst.textBlankHeight*2)

        if CommonData.getDataByBool("bgm_off") == false {
            setCenterButton("戦闘BGMをOFFにする", key_name: "bgm_off", point_y: point_y1)
        } else {
            setCenterButton("戦闘BGMをONにする", key_name: "bgm_on", point_y: point_y1)
        }
        if CommonData.getDataByBool("attack_bgm_off") == false {
            setCenterButton("アタック時の効果音をOFFにする", key_name: "attack_bgm_off", point_y: point_y2)
        } else {
            setCenterButton("アタック時の効果音をONにする", key_name: "attack_bgm_on", point_y: point_y2)
        }
        if CommonData.getDataByBool("attacked_bgm_off") == false {
            setCenterButton("被ダメージ時の効果音をOFFにする", key_name: "attacked_bgm_off", point_y: point_y3)
        } else {
            setCenterButton("被ダメージ時の効果音をONにする", key_name: "attacked_bgm_on", point_y: point_y3)
        }
        
        if CommonData.getDataByBool("coin_bgm_off") == false {
            setCenterButton("コインの効果音をOFFにする", key_name: "coin_bgm_off", point_y: point_y4)
        } else {
            setCenterButton("コインの効果音をONにする", key_name: "coin_bgm_on", point_y: point_y4)
        }
        
        setCenterText("音楽　(C)PANICPUMPKIN", key_name: "copyright", point_y: point_y6)
        
        setBackButton("戻る")
    }
    
    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "back" {
            goTitleScene()
        } else if name == "bgm_off" {
            changeSetting("bgm_off", value: 1)
        } else if name == "attack_bgm_off" {
            changeSetting("attack_bgm_off", value: 1)
        } else if name == "attacked_bgm_off" {
            changeSetting("attacked_bgm_off", value: 1)
        } else if name == "coin_bgm_off" {
            changeSetting("coin_bgm_off", value: 1)
            
        } else if name == "bgm_on" {
            changeSetting("bgm_off", value: 0)
        } else if name == "attack_bgm_on" {
            changeSetting("attack_bgm_off", value: 0)
        } else if name == "attacked_bgm_on" {
            changeSetting("attacked_bgm_off", value: 0)
        } else if name == "coin_bgm_on" {
            changeSetting("coin_bgm_off", value: 0)

        }
    }
    
    func changeSetting(key: String, value: Int){
        CommonData.setData(key, value: value)
        let secondScene = SettingScene(size: self.frame.size)
//        changeSceneWithoutTr(secondScene)
        let skView = self.view! as SKView
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        skView.presentScene(secondScene)
    }
    
    func goTitleScene(){
        let secondScene = TitleScene(size: self.frame.size)
        let tr = SKTransition.doorsOpenHorizontalWithDuration(1)
//        changeSceneWithLongDuration(secondScene, tr: tr)
        let skView = self.view! as SKView
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        skView.presentScene(secondScene, transition: tr)
        
    }
    
    
    
    
    override func update(currentTime: CFTimeInterval) {
    }
    
    
}
