import SwiftUI

/// Static button style that does not show highlighted selection
struct StaticButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
