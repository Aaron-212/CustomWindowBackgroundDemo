import Foundation
import Combine
import SwiftUI

class WindowBackgroundSettings: ObservableObject {
    @Published var style: WindowBackgroundStyle = .regularGlass
    @Published var usingTintColor: Bool = false
    @Published var tintColor: Color = .clear
    
    static let shared = WindowBackgroundSettings()
    
    private init() {}
}
