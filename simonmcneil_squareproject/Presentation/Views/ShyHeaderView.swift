import SwiftUI

struct ShyHeaderView: View {
    @Environment(\.safeAfea) var safeArea

    var body: some View {
        ZStack {
            HStack {
                Image("block")
                    .resizable()
                    .frame(width: 64, height: 64)
                
                Spacer()
            }
            
            HStack {
                Text("Employees")
                    .fontWeight(.bold)
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .padding(.top, safeArea.top)
        .padding(.leading, 6)
        .background(BlurBG())
        .overlay(alignment: .bottom) {
            Rectangle()
                .frame(height: 0.5)
                .opacity(0.5)
        }
    }
}

// Blur background for shy header
struct BlurBG: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        //for dark mode adaptation
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
        view.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

struct ShyHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ShyHeaderView()
    }
}

