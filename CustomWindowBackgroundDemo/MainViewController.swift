import Cocoa
import SwiftUI

class MainViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = NSHostingView(rootView: MainView())
    }
}


