import SwiftUI

fileprivate struct SafeAreaValue: EnvironmentKey {
    static var defaultValue: EdgeInsets = .init(top: UIHelper.safeArea().top,
                                                leading: UIHelper.safeArea().left,
                                                bottom: UIHelper.safeArea().bottom,
                                                trailing: UIHelper.safeArea().right)
}

extension EnvironmentValues {
    var safeAfea: EdgeInsets {
        get {
            self[SafeAreaValue.self]
        } set {
            self[SafeAreaValue.self] = newValue
        }
    }
}
