//
//  CustomNavBar.swift
//  simonmcneil_squareproject
//
//  Created by Simon Mcneil on 2023-01-08.
//

import SwiftUI

struct CustomNavBar: View {
    let show: Bool
    let action: () -> ()
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Leadership Awards")
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
                Text("2022 Employee Winners")
                    .font(.title3)
                    .bold()
                Spacer()
            }
        }
        .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
    }
    
}

struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBar(show: true, action: { print("tapped")})
    }
}
