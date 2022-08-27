//
//  ContentView.swift
//  Shared
//
//  Created by мас on 27.08.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView()
            .buttonStyle(BorderlessButtonStyle())
            .textFieldStyle(PlainTextFieldStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
