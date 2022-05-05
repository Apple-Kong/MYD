//
//  MusicViewModel.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/05.
//

import Foundation


class MusicViewModel: ObservableObject {
    @Published var items: [MusicGenre] = []
    
}
