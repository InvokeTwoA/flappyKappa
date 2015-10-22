// 村の発展画面
import SpriteKit
class MajanScene: BaseScene {
    
    var _per : Int = 0
    override func didMoveToView(view: SKView) {
        setBaseSetting()
        
        let point_y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight*2)
        let point_y2 : CGFloat = point_y1 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y3 : CGFloat = point_y2 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y4 : CGFloat = point_y3 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y5 : CGFloat = point_y4 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y6 : CGFloat = point_y5 - CGFloat(CommonConst.textBlankHeight*2)
        
        
        setCenterText("ざわ……ざわ……", key_name: "hoge", point_y: point_y1)
        setCenterText("勝てば所持金は２倍。負ければ文無し。", key_name: "hoge", point_y: point_y2)

        _per = 40 + _luck        
        setCenterText("あんたの勝率は\(_per)%だ", key_name: "hoge", point_y: point_y3)
        
        setCenterButton("今なら負ける気がしない", key_name: "shoubu", point_y: point_y4)
        setBackButton("帰ります")
    }
    
    
    
    override func checkTochEvent(name: String) {
        if name == "back" {
            goShopScene()
        } else if name == "shoubu"{
            if(_gold == 0){
                showAlert("文無しは帰りな", text: "ここは子供の遊び場じゃねえ", ok_text: "ですよねー。")
                return
            }
            
            
            if(CommonUtil.rnd(100) < _per) {
                let alert: UIAlertController = UIAlertController(title:"ちっ、あんたの勝ちだ",
                    message: "賞金を持って来な",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                
                let buyAction: UIAlertAction = UIAlertAction(title: "にやり",
                    style: UIAlertActionStyle.Default,
                    handler:{
                        (action:UIAlertAction!) -> Void in
                        var gold = CommonData.getDataByInt("gold")
                        gold *= 2
                        CommonData.setData("gold", value: gold)
                        self.reloadScene()
                })
                
                alert.addAction(buyAction)
                self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
                
            } else {
                let alert: UIAlertController = UIAlertController(title:"残念！　これが現実です！",
                    message: "有り金おいてさっさと帰りな",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                let buyAction: UIAlertAction = UIAlertAction(title: "そ、そんなー！",
                    style: UIAlertActionStyle.Default,
                    handler:{
                        (action:UIAlertAction!) -> Void in
                        CommonData.setData("gold", value: 0)
                        self.reloadScene()
                })
                
                alert.addAction(buyAction)
                self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
            }
            
        }
    }
    
    func develop(key_name : String){
        if _gold < 1000 {
            showAlert("お金が足りないよ", text: "村の発展には1000ゴールド必要です", ok_text: "しょんぼり")
        } else {
            print("hoge name=\(key_name)")
            CommonData.plus(key_name, value: 1)
            CommonData.minus("gold", value: 1000)
            reloadScene()
        }
    }
    
    override func saveMoney() {
        return
    }
    
    
    func reloadScene(){
        let secondScene = MajanScene(size: self.frame.size)
        changeSceneWithoutTr(secondScene)
    }
    
    // 冒険へ
    func goShopScene(){
        let secondScene = ShopScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
}

