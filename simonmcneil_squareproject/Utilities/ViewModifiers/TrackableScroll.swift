import SwiftUI

struct TrackableScroll: ViewModifier {
    let offsetChanged: (CGFloat?) -> Void
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear.preference(key: OffsetPreferenceKey.self, value: proxy.frame(in: .global).minY)
                }
            )
            .onPreferenceChange(OffsetPreferenceKey.self) {
                offsetChanged($0)
            }
    }
}
