//
//  Model.swift
//  notepad-swiftui (iOS)
//
//  Created by мас on 29.08.2022.
//

import SwiftUI

struct Note: Identifiable {
    var id = UUID()
        .uuidString
    var note: String
    var date: Date
    var cardColor: Color
}

func getDate(offset: Int) -> Date {
    let calendar = Calendar.current
    
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

var notes: [Note] = [


    
]
