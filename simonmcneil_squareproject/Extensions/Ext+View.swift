import SwiftUI

extension View {
    func trackableListScrollChange(_ newOffset: @escaping (CGFloat?) -> Void) -> some View {
        modifier(TrackableScroll(offsetChanged: newOffset))
    }
    
    func navigationBarColor(_ backgroundColor: UIColor?, titleColor: UIColor) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }
}
