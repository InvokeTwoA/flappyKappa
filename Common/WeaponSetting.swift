import Foundation

class WeaponSetting {
    
    class func getName(key_name :String) -> String {
        var name : String
        switch key_name {
        case "long":
            name = "ロンゲソード"
        case "katana":
            name = "逆刃刀"
        case "shoes":
            name = "ネコのはいた長靴"
        default:
            name = "a"
        }
        return name
    }

    class func getCost(key_name :String) -> Int {
        var cost : Int
        switch key_name {
        case "long":
            cost = 10
        case "katana":
            cost = 20
        case "shoes":
            cost = 3
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
        case "katana":
            name = "定価\(getCost(key_name))ゴールド\n\n殴られると相当痛い刀。\n\n スキル[龍墜閃]\nクリティカル率が100%になります。\n戦闘中の最大HPが2になります"
        case "shoes":
            name = "定価\(getCost(key_name))ゴールド\n\nとんでもなく早く動ける靴。\n\n スキル[縮地]\n戦闘中の敏捷が255になる。\n速すぎるので注意"
        default:
            name = "a"
        }
        return name
    }
    
}