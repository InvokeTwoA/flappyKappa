import SpriteKit

/*
* ゲームの基本画面
*/
class GameScene: BaseScene {
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.0,green:0.5,blue:1.0,alpha:1.0)
        setHeader()
        setKapppaNomi()
        setMoney()
        setShopButton()
        setAdventureButton()
        setStatusButton()
        setEquipButton()
    }
    
    func setKapppaNomi(){
        var kappa : SKSpriteNode = SKSpriteNode(imageNamed: "kappa_nomikai")
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 100)
        kappa.position = point
        self.addChild(kappa)
//        print("self max x = \(CGRectGetMaxX(self.frame))\n")
//        print("self max y = \(CGRectGetMaxY(self.frame))\n")
    }

    // 冒険ボタンを設置
    func setAdventureButton() {
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - CGFloat(CommonConst.textBlankHeight))
        let startButton: SKSpriteNode = CommonUI.normalButton("冒険する", name: "adventure", point: point)
        self.addChild(startButton)
    }
    
    //「街に行く」ボタンを設置
    func setShopButton() {
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - CGFloat(CommonConst.textBlankHeight*3))
        let startButton: SKSpriteNode = CommonUI.normalButton("街にでかける", name: "shop", point: point)
        self.addChild(startButton)
    }

    // ステータス画面へ遷移するボタンを設置
    func setStatusButton() {
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)  - CGFloat(CommonConst.textBlankHeight*5))
        let startButton: SKSpriteNode = CommonUI.normalButton("人生を見直す", name: "status", point: point)
        self.addChild(startButton)
    }
    
    // 装備画面へ遷移するボタンを設置
    func setEquipButton() {
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)  - CGFloat(CommonConst.textBlankHeight*7))
        let startButton: SKSpriteNode = CommonUI.normalButton("装備を整える", name: "equip", point: point)
        self.addChild(startButton)
    }


    // タッチイベント
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as? UITouch
        let location = touch!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        if (touchedNode.name != nil) {
            if touchedNode.name == "shop" {
                goShopScene()
            } else if touchedNode.name == "adventure" {
                goAdventure()
            } else if touchedNode.name == "status" {
                goStatus()
            } else if touchedNode.name == "equip" {
                goEquip()
            }
        }
    }
    
    // 冒険へ
    func goAdventure(){
        let secondScene = MapScene(size: self.frame.size)
        let tr = SKTransition.flipVerticalWithDuration(1)
        changeSceneWithLongDuration(secondScene, tr: tr)
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
        changeSceneWithLongDuration(secondScene, tr: tr)
    }

    // 装備画面へ
    func goEquip(){
        let secondScene = EquipScene(size: self.frame.size)
        let tr = SKTransition.doorsOpenHorizontalWithDuration(1)
        changeSceneWithLongDuration(secondScene, tr: tr)
    }
    
    
    override func update(currentTime: CFTimeInterval) {
    }
    
    
}
