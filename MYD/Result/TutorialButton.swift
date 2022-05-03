//
//  TutorialButton.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/03.
//

import SwiftUI

struct TutorialButton: View {
    
    
    var action: () -> Void
    
    var body: some View {
        
        Button {
            action()
        } label: {
            VStack(alignment: .leading) {
                Text("C-Walk")
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.leading, 12)
                    .padding(.top, 20)
                
                Text("이것은 유튜브 영상의 제목")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .padding(.leading, 12)
                
                Spacer()
                    
                Image("RnB")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 100)
            }
            .frame(width: 160, height: 200)
            .background(Color("Container"))
            .cornerRadius(10)
        }
    }
}

struct TutorialButton_Previews: PreviewProvider {
    static var previews: some View {
        TutorialButton {
            // Button tap
        }
        .previewLayout(.sizeThatFits)
    }
}
