//ダンジョン選択画面
import SpriteKit
class MapScene: BaseScene {
    var _nextScene : SKScene = TutorialStageScene(size: CGSizeMake(1,1))
    let _tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 1)
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.0,green:0.5,blue:1.0,alpha:1.0)
        setHeader()
        setMoney()
        
        let point_y1 = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight)
        let point_y2 = point_y1 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y3 = point_y2 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y4 = point_y3 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y5 = point_y4 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y6 = point_y5 - CGFloat(CommonConst.textBlankHeight*2)
        
        setButton("チュートリアル",   key_name: "tutorial",  point_y: point_y1)
        setButton("スライムの洞窟",   key_name: "slime",     point_y: point_y2)
        setButton("タヌキ平原",      key_name: "tanuki",     point_y: point_y3)
        setButton("古代遺跡",        key_name: "golem",     point_y: point_y4)
        setButton("ゴーレム道場",     key_name: "dojo_g",    point_y: point_y5)
        setButton("ラスボス（魔王城）", key_name: "maou",    point_y: point_y6)
        setBackButton("街に戻るンゴ")
    }
    
    // タッチイベント
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as? UITouch
        let location = touch!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        if (touchedNode.name != nil) {
            CommonData.setData("stage_name", value: touchedNode.name!)
            
            if touchedNode.name == "tutorial" {
                _nextScene = TutorialStageScene(size: self.frame.size)
                showAlert()
            } else if touchedNode.name == "slime" {
                _nextScene = SlimeStageScene(size: self.frame.size)
                showAlert()
            } else if touchedNode.name == "tanuki" {
                _nextScene = TanukiStageScene(size: self.frame.size)
                showAlert()
            } else if touchedNode.name == "golem" {
                _nextScene = GolemStageScene(size: self.frame.size)
                showAlert()
            } else if touchedNode.name == "dojo_g" {
                _nextScene = DojoGStageScene(size: self.frame.size)
                showAlert()
            } else if touchedNode.name == "maou" {
                _nextScene = MaoStageScene(size: self.frame.size)
                showAlert()
            } else if touchedNode.name == "back" {
                backAdventure()
            }
        }
    }
    
    func showAlert(){
        // Style Alert
        let alert: UIAlertController = UIAlertController(title:"どの難易度で行きますか？",
            message: "難易度が高いほど報酬は良くなります。",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let normalAction: UIAlertAction = UIAlertAction(title: "普通の難易度で行く",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                CommonData.setData("danjon_type", value: "normal")
                self.changeScene(self._nextScene, tr: self._tr)
        })
        let hardAction: UIAlertAction = UIAlertAction(title: "ハードモードで行くかな",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                CommonData.setData("danjon_type", value: "hard")
                self.changeScene(self._nextScene, tr: self._tr)
        })
        let specialAction: UIAlertAction = UIAlertAction(title: "難易度カッパ級で行くぜ",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                CommonData.setData("danjon_type", value: "special")
                self.changeScene(self._nextScene, tr: self._tr)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "ビビったので帰る",
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.changeNickname("ヘタレ", percent: 50)
        })
        
        // AddAction 記述順に反映される
        alert.addAction(normalAction)
        alert.addAction(hardAction)
        alert.addAction(specialAction)
        alert.addAction(cancelAction)

        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }

    func backAdventure(){
        let secondScene = GameScene(size: self.frame.size)
        let tr = SKTransition.flipVerticalWithDuration(1)
        changeScene(secondScene, tr: tr)
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
    
}
