//
//  MusicButtonView.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/01.
//

import SwiftUI

struct MusicButtonView: View {

    var text: String
    
    
    var body: some View {
        ZStack {
        
            Color("Container")
            
            //이미지 트림 배치하기
            
            
            VStack {
                HStack {
                    Text(text)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(20)
                    
                    Spacer()
                }
                Spacer()
            }
        }
        .aspectRatio(16 / 14, contentMode: .fit)
        .cornerRadius(10)
    }
}

struct MusicButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MusicButtonView(text: "R&B")
                .frame(height: 140)
                .previewLayout(.sizeThatFits)
            
            MusicGrid()
        }
    }
}

struct MusicGrid: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 20),
                GridItem(.flexible())
            ], spacing: 20) {
                ForEach(0..<20) { item in
                    MusicButtonView(text: "R&B")
                }
            }
        .padding(.horizontal, 20)
        }
    }
}


