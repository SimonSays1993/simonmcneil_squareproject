import SwiftUI

extension View {
    func trackableListScrollChange(_ newOffset: @escaping (CGFloat?) -> Void) -> some View {
        modifier(TrackableScroll(offsetChanged: newOffset))
    }
}
