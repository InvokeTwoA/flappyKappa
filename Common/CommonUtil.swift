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
        var rand = Int(arc4random_uniform(UInt32(max)))
        return rand
    }

    // 距離の表示
    class func displayDistance(distance : Int) -> String{
        var res : String
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
        var formatter = NSNumberFormatter()
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
        var day = CommonData.getDataByInt("day")
        var year : Int = (day/365) + 1
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
        let rnd : Int = CommonUtil.rnd(9)
        switch rnd {
        case 0:
            str = "魔王のHPは日数と一緒"
        case 1:
            str = "麻雀の勝率は(40+幸運)"
        case 2:
            str = "幸運の最大値は50"
        case 3:
            str = "敏捷の最大値は50"
        case 4:
            str = "HPはLVup時に(1〜体力)増える"
        case 5:
            str = "カッパ神ばんざーい"
        case 6:
            str = "裏面が一つ存在する"
        case 7:
            str = "魔法はダメージ固定"
        case 8:
            str = "死亡回数＝初期ゴールド"

        default:
            str = "ぶひー！"
        }
        return str
    }
    
}