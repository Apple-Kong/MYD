//
//  DiagonalAppearance.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/01.
//

import SwiftUI

struct DiagonalFrame: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: 200))
        // 2.
        path.addLine(to: CGPoint(x: 100, y: 0))
        // 3.
        path.addLine(to: CGPoint(x: 300, y: 0))
        
        path.addLine(to: CGPoint(x: 300, y: 300))
        
        path.addLine(to: CGPoint(x: 0, y: 300))
        
        
        //path 를 닫아주어야함.
        path.closeSubpath()
        
        return path
    }
}

struct DiagonalFrame_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DiagonalFrame()
            
            Image("boombap")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(
                    DiagonalFrame()
                )
                .frame(width: 300, height: 300)
                .previewLayout(.sizeThatFits)
        }
    }
}
