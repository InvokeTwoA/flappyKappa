// 転職屋
import SpriteKit

class JobScene: BaseScene {
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.0,green:0.5,blue:1.0,alpha:1.0)
        setBaseSetting()

        let point_y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight*2)
        let point_y2 : CGFloat = point_y1 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y3 : CGFloat = point_y2 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y4 : CGFloat = point_y3 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y5 : CGFloat = point_y4 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y6 : CGFloat = point_y5 - CGFloat(CommonConst.textBlankHeight*2)

        setCenterText("今すぐに転職だ！", key_name: "text1", point_y: point_y1)
        setCenterButton("戦士", key_name: "warrior", point_y: point_y2)
        setCenterButton("魔法使い", key_name: "wizardly", point_y: point_y3)
        setCenterButton("僧侶", key_name: "priest", point_y: point_y4)
        setCenterButton("盗賊", key_name: "thief", point_y: point_y5)
        
        if( _day > 5) {
            if(_equip == "hammer") {
                setCenterButton("大工", key_name: "daiku", point_y: point_y6)
            } else if(_equip == "oretue") {
                setCenterButton("賢者", key_name: "kenja", point_y: point_y6)
            } else if _nickname == "真の" {
                setCenterButton("勇者", key_name: "hero", point_y: point_y6)
            } else if _nickname == "文無し" {
                setCenterButton("勝負師", key_name: "akagi", point_y: point_y6)
            } else if _nickname == "即戦力の"{
                setCenterButton("プロデューサー", key_name: "p", point_y: point_y6)
            } else {
                setCenterButton("遊び人", key_name: "asobi", point_y: point_y6)
            }
        }
        
        setBackButton("そろそろ帰るぜ")
    }

    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "warrior" {
            goJobWarriorScene()
        } else if name == "wizardly" {
            goJobWizardScene()
        } else if name == "priest" {
            goJobPriestScene()
        } else if name == "thief" {
            goJobThiefScene()
        } else if name == "daiku" {
            goJobDaikuScene()
        } else if name == "akagi" {
            goJobAkagiScene()
        } else if name == "p" {
            goJobProducerScene()
        } else if name == "asobi" {
            goJobAsobiScene()
        } else if name == "hero" {
            goJobHeroScene()
        } else if name == "kenja" {
            goJobKenjaScene()
        } else if name == "back" {
            goShopScene()
        }
    }
    
    // 街画面へ戻る
    func goShopScene(){
        saveMoney()
        let skView = self.view! as SKView
        let secondScene = ShopScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 0.5)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        skView.presentScene(secondScene, transition: tr)
    }
    
    func goJobWarriorScene(){
        let secondScene = JobWarriorScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    func goJobWizardScene(){
        let secondScene = JobWizardScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    func goJobPriestScene(){
        let secondScene = JobPriestScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    func goJobThiefScene(){
        let secondScene = JobThiefScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    func goJobProducerScene(){
        let secondScene = JobProducerScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }

    func goJobDaikuScene(){
        let secondScene = JobDaikuScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }

    func goJobAkagiScene(){
        let secondScene = JobAkagiScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    func goJobHeroScene(){
        let secondScene = JobHeroScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    func goJobAsobiScene(){
        let secondScene = JobAsobiScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    func goJobKenjaScene(){
        let secondScene = JobKenjaScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    
    override func update(currentTime: CFTimeInterval) {
    }
}

