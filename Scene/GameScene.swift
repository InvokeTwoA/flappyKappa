import SpriteKit

/*
* ゲームの基本画面
*/
class GameScene: BaseScene {
    
    override func didMoveToView(view: SKView) {
        setBaseSetting()

        
        let point_y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight*2)
        let point_y2 : CGFloat = point_y1 - CGFloat(CommonConst.textBlankHeight*3)
        let point_y3 : CGFloat = point_y2 - CGFloat(CommonConst.textBlankHeight*3)
        let point_y4 : CGFloat = point_y3 - CGFloat(CommonConst.textBlankHeight*3)
        let point_y5 : CGFloat = point_y4 - CGFloat(CommonConst.textBlankHeight*3)
        

        setPicture("miku_32_32", key_name: "miku", point_y: point_y1)
        setButton("冒険する",     key_name: "adventure", point_y:  point_y2)
        setButton("街に出かける",  key_name: "shop", point_y:  point_y3)
        setButton("人生を見直す",  key_name: "status", point_y:  point_y4)
        setButton("装備を整える",  key_name: "equip", point_y:  point_y5)
    }

    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "shop" {
            goShopScene()
        } else if name == "adventure" {
            goAdventure()
        } else if name == "status" {
            goStatus()
        } else if name == "equip" {
            goEquip()
        } else if name == "miku" {
            talkMiku()
        }
    }
    
    // 冒険へ
    func goAdventure(){
        let secondScene = MapScene(size: self.frame.size)
        let tr = SKTransition.flipVerticalWithDuration(1)
        changeScene(secondScene, tr: tr)
    }
    
    // 街画面へ
    func goShopScene(){
        let secondScene = ShopScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    // ステータス画面へ
    func goStatus(){
        let secondScene = StatusScene(size: self.frame.size)
        let tr = SKTransition.doorsOpenHorizontalWithDuration(1)
        changeScene(secondScene, tr: tr)
    }

    // 装備画面へ
    func goEquip(){
        let secondScene = EquipScene(size: self.frame.size)
        let tr = SKTransition.doorsOpenHorizontalWithDuration(1)
        changeScene(secondScene, tr: tr)
    }
    
    func talkMiku(){
        if (CommonData.getDataByInt("story") == 1)  {
            showAlert("世を憂う少女", text:"世界は闇に支配されています。\n(背景描くのが面倒だった訳ではないんです。魔王の仕業です)\n\nどうか魔王を倒してください\n\n(´；ω；｀)\n\n", ok_text: "俺に任せな")
        } else {
            showAlert("魔王を倒してくれてありがとう！", text:"あなたこそが真の勇者です！\n\n( ＾ω＾)", ok_text: "照れるぜ")
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
    }
    
    
}
