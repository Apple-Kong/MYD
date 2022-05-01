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
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("Container"))
                .frame(height: 64)
            
                
            Text(text)
                .foregroundColor(.white)
                .font(.title3)
                .fontWeight(.bold)
                
        }
    }
}

struct PreferenceButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceButtonView(text: "친구들과 영상을 찍기 위해")
            .previewLayout(.sizeThatFits)
    }
}
