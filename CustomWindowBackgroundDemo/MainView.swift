import SwiftUI

struct MainView: View {
    @StateObject private var settings = WindowBackgroundSettings.shared

    var body: some View {
        VStack {
            Text("Custom Window Background Demo")
                .font(.largeTitle)

            Picker("Select Style", selection: $settings.style) {
                ForEach(WindowBackgroundStyle.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(.menu)

            Toggle("Use Tint Color", isOn: $settings.usingTintColor)

            ColorPicker("Tint Color", selection: $settings.tintColor)
                .disabled(!settings.usingTintColor)
        }
    }
}
