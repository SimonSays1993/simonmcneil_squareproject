import SwiftUI

struct CustomNavBar: View {
    let show: Bool
    let action: () -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
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
            }
            
            Text("Meet some employees at Block")
                .font(.title3)
                .bold()
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBar(show: true, action: { print("tapped")})
    }
}
