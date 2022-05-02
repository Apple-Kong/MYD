//
//  MusicButtonView.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/01.
//

import SwiftUI



struct MusicButtonView: View {
    
    let item: MusicGenre
    
    @Binding var items: [MusicGenre]
    
    
    var body: some View {
        
        Button {
            if items.contains(item) {
                items.removeAll { $0 == item }
            } else {
                items.append(item)
            }
            print(items)
        } label: {
            ZStack {
                Image("boombap")
                    .resizable()
                    .clipShape(
                        DiagonalFrame()
                )
                
                VStack {
                    HStack {
                        Text(item.rawValue)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(20)
    
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        .aspectRatio(16 / 14, contentMode: .fit)
        .background(Color("Container"))
        .cornerRadius(10)
        .if(items.contains(item)) { view in
            view.overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .fill(Color("AccentColor"))
            )
        }
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
//            MusicButtonView(text: "R&B", isSelected: .constant(false))
//                .frame(height: 140)
//                .previewLayout(.sizeThatFits)
//
//
//            MusicButtonView(text: "R&B", isSelected: .constant(true))
//                .frame(height: 140)
//                .previewLayout(.sizeThatFits)
            
            MusicGrid()
                .preferredColorScheme(.dark)
        }
    }
}


struct MusicGrid: View {
    
    //간격 한번에 설정하기 위한 변수
    var totalSpacing: CGFloat = 20
    
    @State var selectedItems: [MusicGenre] = []
    
    var body: some View {
        ZStack {
                
            VStack {
                HStack {
                Text("음악 취향")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                .foregroundColor(.white)
                
                Text("3개 선택")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                Spacer()
            }
            .frame(height: 50)
            .padding(.leading, 20)
            .background(Color("background")
            .opacity(0.8))
            
                ScrollView {
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: totalSpacing),
                        GridItem(.flexible())
                    ], spacing: totalSpacing
                    ) {
                        ForEach(MusicGenre.allCases, id: \.self) { item in
                
                
                            MusicButtonView(item: item, items: $selectedItems)
                        }
                    }
                .padding(.horizontal, totalSpacing)
                }
                .background(Color("background"))
            }
            
            
            VStack {
                
                Spacer()
                
                VStack {
                    Button {
                        print("DEBUG: button is tapped")
                    } label: {
                        Text("다음")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PreferenceButtonStyle())
                    .padding(20)
                }
                .frame(height: 80)
                .background(Color("background"))
            }
        }
    }
}


