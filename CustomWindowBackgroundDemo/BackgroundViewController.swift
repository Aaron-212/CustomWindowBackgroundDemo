import Cocoa
import SwiftUI
import Combine

class BackgroundViewController: NSViewController {
    
    private var containerView: NSView!
    private var currentBackgroundView: NSView?
    private var cancellables = Set<AnyCancellable>()
    private let settings = WindowBackgroundSettings.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView = NSView()
        containerView.autoresizingMask = [.width, .height]
        self.view = containerView
        
        // Set initial background view before setting up observers
        updateCurrentView()
        setupObservers()
    }
    
    private func setupObservers() {
        Publishers.CombineLatest3(
            settings.$windowBackgroundStyle,
            settings.$usingTintColor,
            settings.$glassTintColor
        )
        .sink { [weak self] style, usingTintColor, tintColor in
            print("Combine observer fired: \(style.rawValue), usingTintColor: \(usingTintColor)")
            self?.updateCurrentView(style: style, usingTintColor: usingTintColor, tintColor: tintColor)
        }
        .store(in: &cancellables)
    }

    func replaceView(with newView: NSView) {
        currentBackgroundView?.removeFromSuperview()
        
        newView.frame = containerView.bounds
        newView.autoresizingMask = [.width, .height]
        
        containerView.addSubview(newView)
        currentBackgroundView = newView
    }

    func createView(
        for style: WindowBackgroundStyle,
        usingTintColor: Bool = false,
        tintColor: Color = .clear,
    ) -> NSView {
        switch style {
        case .regularGlass:
            let view = NSGlassEffectView()
            view.cornerRadius = 16
            view.style = .regular
            if usingTintColor {
                view.tintColor = NSColor(tintColor)
            }
            return view

        case .clearGlass:
            let view = NSGlassEffectView()
            view.cornerRadius = 16
            view.style = .clear
            if usingTintColor {
                view.tintColor = NSColor(tintColor)
            }
            return view

        case .hudWindow:
            let view = NSVisualEffectView()
            view.material = .hudWindow
            view.blendingMode = .behindWindow
            view.state = .active
            view.wantsLayer = true
            return view

        case .popover:
            let view = NSVisualEffectView()
            view.material = .popover
            view.blendingMode = .behindWindow
            view.state = .active
            view.wantsLayer = true
            return view

        case .menu:
            let view = NSVisualEffectView()
            view.material = .menu
            view.blendingMode = .behindWindow
            view.state = .active
            view.wantsLayer = true
            return view

        case .underWindowBackground:
            let view = NSVisualEffectView()
            view.material = .underWindowBackground
            view.blendingMode = .behindWindow
            view.state = .active
            view.wantsLayer = true
            return view

        case .titlebar:
            let view = NSVisualEffectView()
            view.material = .titlebar
            view.blendingMode = .behindWindow
            view.state = .active
            view.wantsLayer = true
            return view
        }
    }

    func updateCurrentView() {
        let style = settings.windowBackgroundStyle
        let usingTintColor = settings.usingTintColor
        let tintColor = settings.glassTintColor
        updateCurrentView(style: style, usingTintColor: usingTintColor, tintColor: tintColor)
    }

    func updateCurrentView(style: WindowBackgroundStyle, usingTintColor: Bool, tintColor: Color) {
        print("Updating background style to \(style.rawValue), usingTintColor: \(usingTintColor), tintColor: \(tintColor)")
        let newView = createView(for: style, usingTintColor: usingTintColor, tintColor: tintColor)
        replaceView(with: newView)
    }

}
