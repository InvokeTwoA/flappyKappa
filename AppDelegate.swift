import UIKit
import GameKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(loginVC, error) -> Void in
            if GKLocalPlayer.localPlayer().authenticated {
            
                // GameCenter 認証成功
                print("game center authenticated")
            } else if loginVC != nil {
                print("game center sign in.")
                self.window?.rootViewController?.presentViewController(loginVC, animated: true, completion: nil)
            } else {
                if error != nil {
                    print("error : \(error.code)  ( \(error.description) )")
                }
            }
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }


}

