// 次元の狭間
import SpriteKit
class JigenScene: BaseScene {
    
    override func didMoveToView(view: SKView) {
        setBaseSetting()
        
        let point_y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight)
        let point_y2 : CGFloat = point_y1 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y3 : CGFloat = point_y2 - CGFloat(CommonConst.textBlankHeight*2)
        
        setCenterButton("レビューしてあげよう", key_name: "review", point_y: point_y1)
        setCenterPicture("miku_32_32",              key_name: "miku", point_y: point_y2)
        setCenterButton("過去の物語をプレイする", key_name: "kako", point_y: point_y3)
        
        setBackButton("こんな場所にもう用はない！")
    }
    
    //「転職」ボタンを設置
    func setJobChangeButton() {
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight*4))
        let startButton: SKSpriteNode = CommonUI.normalButton("転職するか", name: "job", point: point)
        self.addChild(startButton)
    }
    
    override func checkTochEvent(name: String) {
        if name == "kako" {
            goKako()
        } else if name == "miku" {
            talkMiku()
        } else if name == "review" {
            goReview()
        } else if name == "back" {
            goGameScene()
        }
    }
    
    // 冒険へ
    func goGameScene(){
        let secondScene = GameScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    func goReview() {
        let appID = CommonConst.appleId
        let itunesURL:String = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=\(appID)"
        let url = NSURL(string:itunesURL)
        let app:UIApplication = UIApplication.sharedApplication()
        app.openURL(url!)
    }
    
    func goKako() {
        let appID = CommonConst.senjoId
        let itunesURL:String = "itms-apps://itunes.apple.com/app/bars/id\(appID)"
        print("url=\(itunesURL)")
        let url = NSURL(string:itunesURL)
        let app:UIApplication = UIApplication.sharedApplication()
        app.openURL(url!)
    }
    
    func talkMiku(){
        showAlert("看板娘", text:"レビューをしてくれたらカッパ神は心から喜ぶんだよ", ok_text: "いつつの……星が呼んでる……？")
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
    
    
}

