//
//  View.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/05.
//

import Foundation
import SwiftUI


extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
