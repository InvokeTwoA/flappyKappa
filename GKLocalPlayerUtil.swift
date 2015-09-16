import UIKit
import GameKit

struct GKLocalPlayerUtil {
    static var localPlayer:GKLocalPlayer = GKLocalPlayer();
    
    static func login(target:UIViewController){
        self.localPlayer = GKLocalPlayer();
        self.localPlayer.authenticateHandler = {(viewController, error) -> Void in
            
            if ((viewController) != nil) {
                println("ログイン確認処理：失敗-ログイン画面を表示");
                target.presentViewController(viewController, animated: true, completion: nil);
            }else{
                println("ログイン確認処理：成功");
                if (error == nil){
                    println("ログイン認証：成功");
                }else{
                    println("ログイン認証：失敗");
                }
            }
        }
    }
}