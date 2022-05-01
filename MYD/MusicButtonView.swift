//
//  MusicButtonView.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/01.
//

import SwiftUI

struct MusicButtonView: View {
    
    var text: String
    
    @Binding var isSelected: Bool
    
    
    var body: some View {
        ZStack {
        
            Color("Container")
            
            //이미지 트림 배치하기
            
            Image("boombap")
                .resizable()
                .clipShape(
                    DiagonalFrame()
                )
            
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
        .if(isSelected, transform: { view in
            view.overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("AccentColor"), lineWidth: 2.5)
            )
        })
    }
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}


struct MusicButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MusicButtonView(text: "R&B", isSelected: .constant(false))
                .frame(height: 140)
                .previewLayout(.sizeThatFits)
            
            
            MusicButtonView(text: "R&B", isSelected: .constant(true))
                .frame(height: 140)
                .previewLayout(.sizeThatFits)
            
            MusicGrid()
        }
    }
}

struct MusicGrid: View {
    
    //간격 한번에 설정하기 위한 변수
    var totalSpacing: CGFloat = 14
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: totalSpacing),
                GridItem(.flexible())
            ], spacing: totalSpacing) {
                ForEach(0..<20) { item in
                    MusicButtonView(text: "R&B", isSelected: .constant(false))
                }
            }
        .padding(.horizontal, totalSpacing)
        }
    }
}


