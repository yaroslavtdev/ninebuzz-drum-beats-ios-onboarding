
import Foundation
import SwiftUI


public class SurveyViewController<ContentView>: UIHostingController<ContentView> where ContentView : View {

    public override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
    }
    
    // Portrait only for iPhone
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return [.portrait, .portraitUpsideDown]
        } else {
            return .all
        }
    }
    public override var shouldAutorotate: Bool {
        return true
    }
}

