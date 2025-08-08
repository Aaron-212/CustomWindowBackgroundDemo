import Cocoa

class MainWindowController: NSWindowController {

    var backgroundViewController: BackgroundViewController?
    var mainViewController: MainViewController?

    override var windowNibName: NSNib.Name? {
        return NSNib.Name("MainWindow")
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        configureWindow()
        setupBackgroundViewController()
    }

    private func configureWindow() {
        guard let window = window else { return }

        window.setContentSize(NSSize(width: 640, height: 640))
        window.minSize = NSSize(width: 240, height: 240)

        window.center()

        window.backgroundColor = .clear
        window.hasShadow = true

        window.makeKeyAndOrderFront(nil)
    }

    private func setupBackgroundViewController() {
        backgroundViewController = BackgroundViewController()
        mainViewController = MainViewController()

        guard let contentView = window?.contentView else { return }
        guard let backgroundView = backgroundViewController?.view else { return }
        guard let mainView = mainViewController?.view else { return }

        // Set frames to fill the entire content view
        backgroundView.frame = contentView.bounds
        mainView.frame = contentView.bounds
        
        // Enable autoresizing to maintain full size when window resizes
        backgroundView.autoresizingMask = [.width, .height]
        mainView.autoresizingMask = [.width, .height]

        contentView.addSubview(backgroundView, positioned: .below, relativeTo: nil)
        contentView.addSubview(mainView)
    }
}


