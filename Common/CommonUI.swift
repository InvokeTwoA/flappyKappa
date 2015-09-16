/*
 * 共通のUIなどを実装するクラス
 */

import Foundation
import SpriteKit

class CommonUI {

    /*
     * ボタンを返す関数。背景色は白で、文字色は黒。表示する文字数が多いと横幅が増える
     * text: ボタンに表示する文字列
     * name: タグ名。イベントの検出に使われる
     * point: 座標
     */
    class func normalButton(text: String, name: String, point: CGPoint) -> SKSpriteNode {
        var size : CGSize;
        //print("文字の長さは \(text.utf16Count)\n")
        if count(text.utf16) <= 5 {
            size = CGSizeMake(100, 30)
        } else {
            // 1文字15と考えて、文字超過分の幅を増やす
            var width : CGFloat = CGFloat(100+(count(text.utf16)-5)*15)
            size = CGSizeMake(width, 30)
        }

        // ボタン枠組み（背景）
        var background : SKSpriteNode = SKSpriteNode(color: UIColor.whiteColor(), size: size)
        background.position = point
        background.zPosition = 100
        background.name = name

        // ボタン
        var button : SKLabelNode = SKLabelNode(fontNamed:CommonConst.font_regular)
        button.text = text
        button.fontSize = 18
        button.position = CGPointMake(0, -button.frame.size.height/2+3);
        button.fontColor = UIColor.blackColor()
        button.name = name

        background.addChild(button)
        return background
    }
    
    class func normalText(text: String, name: String, point: CGPoint) -> SKLabelNode {
        // ボタン
        var button : SKLabelNode = SKLabelNode(fontNamed:CommonConst.font_regular)
        button.text = text
        button.fontSize = 18
        button.position = point;
        button.fontColor = UIColor.whiteColor()
        button.name = name
        
        return button
    }
    
    /*
     * alertダイアログを表示(特にコールバック処理などしない表示オンリーの場合)
     * title : alertダイアログのtitle
     * message : 本分
     * okMessage: 「はい」などの完了文言
     */
    class func normalAlert(title: String, message: String, okMessage: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: okMessage, style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        return alertController
        /*
        let cancelAction = UIAlertAction(title: "CANCEL", style: .Cancel) {
        action in println("Pushed CANCEL!")
        }
        */
    }    
    
    class func setHp() -> SKLabelNode {
        var hp : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        var hp_value : Int = CommonData.getData("hp") as! Int
        hp.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        hp.text = "\(hp_value)"
        hp.fontSize = 18
        hp.position = CGPointMake(-100, 30)
        hp.fontColor = UIColor.blackColor()
        hp.name = "hp_label"
        return hp
    }
    
    class func setWorldPhysic(size: CGSize) -> SKPhysicsBody {
        let physic = SKPhysicsBody(rectangleOfSize: size)
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.dynamic = false
        physic.categoryBitMask = wallCategory
        return physic
    }
    
    class func displayName() -> String {
        let job      = CommonData.getData("job") as! String
        let nickname = CommonData.getData("nickname") as! String
        let name     = CommonData.getData("name") as! String
        return "\(nickname)\(job)\(name)"
    }
}
