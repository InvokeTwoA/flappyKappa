import UIKit
import SpriteKit
import AVFoundation

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! TitleScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController, NADViewDelegate, AVAudioPlayerDelegate  {
    private var nadView: NADView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // skviewの設定
        /*
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = true
        skView.ignoresSiblingOrder = true
        */
        showAd()
        showTitleScene()
    }
    
    func showAd() {
        nadView = NADView(frame: CGRect(x: 0, y: 0, width: 320, height: CommonConst.adHeight))
        nadView.setNendID(CommonConst.adKey, spotID: CommonConst.adSpot)
        nadView.isOutputLog = false
        nadView.delegate = self
        nadView.load()
        self.view?.addSubview(nadView)
    }
    
    func nadViewDidFinishLoad(adView: NADView!) {
    }
    
    
    
    // タイトル画面へ移動
    func showTitleScene(){
        let scene = TitleScene(size: UIScreen.mainScreen().bounds.size)        
        let skView = self.view as! SKView
        scene.scaleMode = .AspectFill
        skView.presentScene(scene)
    }

    override func shouldAutorotate() -> Bool {
        return false
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return UIInterfaceOrientationMask.AllButUpsideDown
        } else {
            return UIInterfaceOrientationMask.All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
