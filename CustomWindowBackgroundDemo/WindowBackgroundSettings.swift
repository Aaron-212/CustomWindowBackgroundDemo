import Foundation
import Combine
import SwiftUI

class WindowBackgroundSettings: ObservableObject {
    @Published var windowBackgroundStyle: WindowBackgroundStyle = .regularGlass
    @Published var usingTintColor: Bool = false
    @Published var glassTintColor: Color = .clear

    static let shared = WindowBackgroundSettings()
    
    private init() {}
}
