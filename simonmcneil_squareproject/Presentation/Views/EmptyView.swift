import SwiftUI

struct EmptyView: View {
    var body: some View {
        LazyVStack(spacing: 16) {
            Spacer()
            Text("No Employees Found")
            Image(systemName: "person.crop.circle.badge.exclamationmark")
                .font(.system(size: 100))
            Spacer()
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
