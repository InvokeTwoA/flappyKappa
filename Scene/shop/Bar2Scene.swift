// 酒場の画面
import SpriteKit
class Bar2Scene: BaseScene {
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.0,green:0.5,blue:1.0,alpha:1.0)
        setBaseSetting()
        
        let point_y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight)
        let point_y2 : CGFloat = point_y1 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y3 : CGFloat = point_y2 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y4 : CGFloat = point_y3 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y5 : CGFloat = point_y4 - CGFloat(CommonConst.textBlankHeight*2)
        setCenterButton("怪しい神父",       key_name: "kami", point_y: point_y1)
        setCenterButton("かわいい子",       key_name: "kawaii", point_y: point_y2)
        setCenterButton("ランダムじいさん",   key_name: "hint", point_y: point_y3)
        setCenterButton("鏡の騎士の被害者",   key_name: "kagami", point_y: point_y4)
        setCenterButton("さらに別の酒場へGO！", key_name: "sanji", point_y: point_y5)        
        setBackButton("あばよ！")
    }
    
    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "kami" {
            talkKami()
        } else if name == "kawaii" {
            talkKawaii()
        } else if name == "hint" {
            talkHint()
        } else if name == "kagami" {
            talkKagami()
         } else if name == "sanji" {
            goBar3Scene()
        } else if name == "back" {
            goShopScene()
        }
    }
    
    func goBar3Scene(){
        let secondScene = Bar3Scene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }

    
    func talkKami(){
        showAlert("おお、神よ！", text:"セーブデータを消したいならばタイトル画面で「地球を破壊する」を4回押せば良いのですね", ok_text: "……関わらないでおこう")
    }
    
    func talkKawaii(){
        if (CommonData.getDataByInt("story") == 1)  {
            showAlert("冴えないカッパね", text:"気安く話しかけないでくれる？", ok_text: "しょんぼり　(´・ω・｀)")
        } else {
            showAlert("きゃー、素敵！", text:"あなたこそがカッパの中のカッパ！\n\nカッパ・オブ・カッパだわ！", ok_text: "照れるぜ")
        }
    }
    
    func talkHint(){
        showAlert("ヒントをやろう", text:CommonUtil.randomHint(), ok_text: "ふむふむ")
    }
    
    func talkKagami(){
        showAlert("どうしても勝てない……", text: "俺が飛べばヤツも飛ぶ。\n俺が右に動けばヤツは左に動く。\n俺が剣を投げればヤツはスライムを召喚。\n\nヤツのHPは俺と一緒。\nヤツの力は俺と一緒。\nヤツの防御力は俺の体力と一緒。", ok_text: "仇は俺が取る")
    }
    
    func goShopScene(){
        let secondScene = ShopScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
}

