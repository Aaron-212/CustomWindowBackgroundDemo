import SwiftUI

struct MainView: View {
    @ObservedObject private var settings = WindowBackgroundSettings.shared

    var body: some View {
        VStack {
            Text("Custom Window Background Demo")
                .font(.largeTitle)

            Picker("Select Style", selection: $settings.windowBackgroundStyle) {
                ForEach(WindowBackgroundStyle.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(.menu)

            Toggle("Use Tint Color", isOn: $settings.usingTintColor)

            ColorPicker("Tint Color", selection: $settings.glassTintColor)
                .disabled(!settings.usingTintColor)
        }
    }
}
