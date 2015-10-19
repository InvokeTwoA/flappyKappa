import Foundation
import SpriteKit

/*
* ゲームの基本画面
*/
class SettingScene: BaseScene {
    
    override func didMoveToView(view: SKView) {
        setBaseSetting()
        
        // BGMの on/off
        // 効果音（敵に攻撃を当てた）
        // 効果音（ダメージを受けた）
        // コイン取得時の効果音
        
        setBackButton("戻る")
    }
    
    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "back" {
            goTitleScene()
        }
    }
    
    func goTitleScene(){
        let secondScene = TitleScene(size: self.frame.size)
        let tr = SKTransition.doorsOpenHorizontalWithDuration(1)
        changeSceneWithLongDuration(secondScene, tr: tr)    
    }
    
    
    override func update(currentTime: CFTimeInterval) {
    }
    
    
}
