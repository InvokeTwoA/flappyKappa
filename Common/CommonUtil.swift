/*
* 便利な関数
*/

import Foundation
import SpriteKit
class CommonUtil {
    // 0 から max までの乱数
    class func rnd(max : Int) -> Int {
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
    
    // お金の桁数表示
    // 2,000,000 のように３桁ずつカンマで表示
    class func displayMoney(gold: Int) -> String {
        var formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        var str : String = "所持金: \(formatter.stringFromNumber(gold)!)　ゴールド"
        return str
    }
}
