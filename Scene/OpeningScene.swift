// エンディング表示クラス
// ここに関しては静的な画面なので、BaseSceneを継承しない

import SpriteKit
import Social

class OpeningScene: BaseScene {
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.1,green:0.1,blue:0.1,alpha:0.1)
        setBaseSetting()
     
        let point_y1 = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight)
        let point_y2 = point_y1 - CGFloat(CommonConst.textBlankHeight*3)
        let point_y3 = point_y2 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y4 = point_y3 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y5 = point_y4 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y6 = point_y5 - CGFloat(CommonConst.textBlankHeight*2)
        setCenterText("真の勇者とは何か……。", key_name: "text1", point_y: point_y1)
        setCenterText("21XX年。世界は闇に支配されていた。", key_name: "text2", point_y: point_y2)
        setCenterText("そんな時、世界に光を取り戻そうと", key_name: "text3", point_y: point_y3)
        setCenterText("一匹のカッパが立ち上がった。", key_name: "text3", point_y: point_y4)
        setCenterText("「カッパに勇者なんて無理だよ」と", key_name: "text4", point_y: point_y5)
        setCenterText("誰もが笑い本気にしなかった", key_name: "text5", point_y: point_y6)
        
        NSTimer.scheduledTimerWithTimeInterval(7.0, target: self, selector: Selector("goNext"), userInfo: nil, repeats: false)
    }
    
    func goNext(){
        let secondScene = GameScene(size: self.frame.size)
        let tr = SKTransition.fadeWithColor(UIColor.whiteColor(), duration: 2.0)
        changeScene(secondScene, tr: tr)
    }
    
    override func setMoney(){
        return
    }
    
    override func setHeader(){
        return
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
    
}
