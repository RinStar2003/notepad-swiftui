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

    Note(note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", date: getDate(offset: 1), cardColor: Color("blue")),
    Note(note: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ", date: getDate(offset: -10), cardColor: Color("green")),
    Note(note: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.", date: getDate(offset: -15), cardColor: Color("orange")),
    Note(note: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", date: getDate(offset: 10), cardColor: Color("pink")),
    Note(note: "wqfanbsfbajfvajkjhbf`jhfajhbasjhbwr", date: getDate(offset: -3), cardColor: Color("purple")),
    Note(note: "fasfqgx", date: getDate(offset: -8), cardColor: Color("yellow"))

]
