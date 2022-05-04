//
//  PreferenceButton.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/01.
//

import SwiftUI

struct PreferenceButtonView: View {
    
    var text: String
    
    var body: some View {
        ZStack {
        
            Color("Container")
                
            Text(text)
                .foregroundColor(.white)
                .font(.title3)
                .fontWeight(.bold)
                
        }
        .frame(height: 54)
        .cornerRadius(10)
    }
}

struct PreferenceButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceButtonView(text: "친구들과 영상을 찍기 위해")
            .previewLayout(.sizeThatFits)
    }
}
