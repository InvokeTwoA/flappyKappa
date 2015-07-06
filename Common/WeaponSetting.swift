import Foundation

class WeaponSetting {
    
    class func getName(key_name :String) -> String {
        var name : String
        switch key_name {
        case "long":
            name = "ロンゲソード"
        case "a":
            name = "a"
        default:
            name = "a"
        }
        return name
    }

    class func getCost(key_name :String) -> Int {
        var cost : Int
        switch key_name {
        case "long":
            cost = 100
        case "a":
            cost = 10
        default:
            cost = 0
            break // do nothing
        }
        return cost
    }
    
    class func getExplain(key_name :String) -> String {
        var name : String
        switch key_name {
        case "long":
            name = "定価\(getCost(key_name))ゴールド\n\nロンゲの兄ちゃんが使ってた剣。\n\n スキル[ブロック崩し]\nブロックを破壊できます。"
        case "a":
            name = "a"
        default:
            name = "a"
        }
        return name
    }
    
}