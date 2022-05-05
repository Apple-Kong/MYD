//
//  PreferenceButton.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/01.
//

import SwiftUI

struct PreferenceButtonView: View {
    
    let text: String
    
    @Binding var items: [String]
    
    var body: some View {
        
    
            ZStack {
            
                Color("Container")
                    
                Text(text)
                    .foregroundColor(.white)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    
            }
            .frame(height: 60)
            .cornerRadius(10)
            .if(items.contains(text)) { view in
                view.overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1.5)
                        .fill(Color("AccentColor"))
                )
            }
            .onTapGesture {
                if items.contains(text) {
                    
                    items.removeAll()
                } else {
                    if items.count < 1 {
                        items.append(text)
                    } else {
                        items.removeAll()
                        items.append(text)
                    }
                }
                
                print(items)
            }
    }
}

struct PreferenceButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceButtonView(text: "친구들과 영상을 찍기 위해", items: .constant([]))
            .previewLayout(.sizeThatFits)
    }
}
