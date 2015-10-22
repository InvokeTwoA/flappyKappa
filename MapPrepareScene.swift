//ダンジョン選択画面
import SpriteKit
class MapPrepareScene: BaseScene {
    var _stage = CommonData.getDataByString("stage_name")
    var _nextScene : SKScene = SlimeStageScene(size: CGSizeMake(1,1))
    let _tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 1)
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.0,green:0.5,blue:1.0,alpha:1.0)
        setBaseSetting()
        
        setStage()
        
        
        let point_y1 = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight)
        let point_y2 = point_y1 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y3 = point_y2 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y4 = point_y3 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y5 = point_y4 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y6 = point_y5 - CGFloat(CommonConst.textBlankHeight*2)

        setCenterText(MapSetting.getName(_stage), key_name: "title", point_y: point_y1)
        setCenterText("ボス: \(MapSetting.getBossName(_stage))", key_name: "title", point_y: point_y2)
        setCenterText(MapSetting.getExplain1(_stage), key_name: "explain1", point_y: point_y3)
        setCenterText(MapSetting.getExplain2(_stage), key_name: "explain2", point_y: point_y4)
        setCenterText(MapSetting.getExplain3(_stage), key_name: "explain3", point_y: point_y5)
        setCenterButton("行くぜ", key_name: "go", point_y: point_y6)
    
        setBackButton("ビビったので帰る")
    }
    
    func setStage(){
        _nextScene = MapSetting.nextScene(self.frame.size)
    }
    
    override func checkTochEvent(name: String) {
        if name == "go" {
            showAlert()
        } else if name == "back" {
            changeNickname("ヘタレ", percent: 50)
            backAdventure()
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
        
        // AddAction 記述順に反映される
        alert.addAction(normalAction)
        alert.addAction(hardAction)
        alert.addAction(specialAction)
        
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
