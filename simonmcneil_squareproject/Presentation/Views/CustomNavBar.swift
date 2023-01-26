import SwiftUI

struct CustomNavBar: View {
    let show: Bool
    let action: () -> ()
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Employee Directory")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                if show {
                    Button {
                        action()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.white)
                            .font(.system(.title3, design: .rounded))
                        
                    }
                }
                
                Spacer()
            }
            
            HStack {
                Text("Meet some employees at Block")
                    .font(.title3)
                    .bold()
                Spacer()
            }
        }
        .padding(EdgeInsets(top: 55, leading: 0, bottom: 0, trailing: 0))
    }
}

struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBar(show: true, action: { print("tapped")})
    }
}
