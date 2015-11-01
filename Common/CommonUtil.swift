/*
* 便利な関数
*/

import Foundation
import SpriteKit
class CommonUtil {
    // 0 から max までの乱数
    class func rnd(max : Int) -> Int {
        if(max <= 0){
            return 0
        }
        let rand = Int(arc4random_uniform(UInt32(max)))
        return rand
    }

    // 距離の表示
    class func displayDistance(distance : Int) -> String{
        var distance_km : Int = 0
        var distance_m : Int = 0
        if(distance > 1000){
            distance_km = Int(distance / 1000)
            distance_m = distance%1000
        } else {
            distance_m = distance
        }
        if(distance_km > 0){
            return "\(distance_km) km \(distance_m) m"
        } else {
            return "\(distance_m) m"
        }
    }
    
    // お金の桁数表示（と年数表示）
    // 2,000,000 のように３桁ずつカンマで表示
    class func displayMoney(gold: Int) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        var str = ""
        if gold >= 0 {
            str = "所持金: \(formatter.stringFromNumber(gold)!)"
        } else {
            str = "所持金：　文無し"
            CommonData.setData("gold", value: 0)
        }
        // 年数の表示
        let day = CommonData.getDataByInt("day")
        let year : Int = (day/365) + 1
        str = "カッパ歴\(year)年 \(day)日目  \(str)"
        return str
    }
    
    // 死に際のセリフをランダムに返す
    class func makeDeathWord() -> String {
        let str : String
        let rnd : Int = CommonUtil.rnd(7)
        switch rnd {
        case 0:
            str = "やられたー！"
        case 1:
            str = "ぐあー！"
        case 2:
            str = "ぎゃー！"
        case 3:
            str = "さーせん"
        case 4:
            str = "見事だ……"
        case 5:
            str = "お前がナンバー１だ"
        case 6:
            str = "負けたー"
        default:
            str = "ぶひー！"
        }
        return str
    }
    
    class func randomHint() -> String{
        let str : String
        let rnd : Int = CommonUtil.rnd(31)
        switch rnd {
        case 0:
            str = "魔王のHPは日数と一緒"
        case 1:
            str = "麻雀の勝率は(30+幸運)"
        case 2:
            str = "幸運の最大値は50"
        case 3:
            str = "敏捷の最大値は50"
        case 4:
            str = "HPは50以降上がりにくくなる"
        case 5:
            str = "カッパ神ばんざーい"
        case 6:
            str = "裏面が一つ存在する"
        case 7:
            str = "魔法はダメージ固定"
        case 8:
            str = "死亡回数＝初期ゴールド"
        case 9:
            str = "ハンマー装備で転職屋に行くと……"
        case 10:
            str = "5日以上の冒険で上級職解放"
        case 11:
            str = "幸運7以上で金のスライム出現"
        case 12:
            str = "金のスライムは寄り道ステージで出現"
        case 13:
            str = "魔王には聖剣が有効"
        case 14:
            str = "LV10以降はLV上げが大変"
        case 15:
            str = "力の最大値は50"
        case 16:
            str = "魔力に限界値はない"
        case 17:
            str = "体力の最大値は50"
        case 18:
            str = "精神の最大値は50"
        case 19:
            str = "会心の一撃は相手の防御力を半分で計算"
        case 20:
            str = "会心の一撃は幸運が高いと追加ダメージ"
        case 21:
            str = "「文無し」の時に転職屋に行くと……"
        case 22:
            str = "「真の」の時に転職屋に行くと……"
        case 23:
            str = "ネバーギブアップ"
        case 24:
            str = "「即戦力の」の時に転職屋に行くと……"
        case 25:
            str = "たくさん働いてると「即戦力の」になれるぞ"
        case 26:
            str = "「魔の」子供だと体力や力が1になる代わり膨大な魔力を持つそうだ"
        case 27:
            str = "たまに文無しやお金持ちな勇者が誕生する事がある"
        case 28:
            str = "即戦力の勇者だと初めからレベル10らしい"
        case 29:
            str = "アプリを宣伝してくれると作者は泣いて喜ぶのだ"
        case 30:
            str = "攻略サイトをググれ！"
        default:
            str = "ぶひー！"
        }
        return str
    }
    
    class func screenShot(view : UIView) -> UIImage {
        // スクリーンショットの取得開始
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 1.0)
        
        // 描画
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        
        // 描画が行われたスクリーンショットの取得
        let screenShot = UIGraphicsGetImageFromCurrentImageContext()
        // スクリーンショットの取得終了
        UIGraphicsEndImageContext()
        return screenShot
    }
}