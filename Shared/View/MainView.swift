//
//  MainView.swift
//  notepad-swiftui (iOS)
//
//  Created by мас on 27.08.2022.
//

import SwiftUI

struct MainView: View {
    
    @State var isColorShowed = false
    
    var body: some View {
        HStack(spacing: 0) {
            if isMacOS() {
                Group {
                    SideBar()
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.15))
                        .frame(width: 1)
                }
                
            }
            
            // Main
        }
        .ignoresSafeArea()
        .frame(width: isMacOS() ? getRectangle().width / 1.7 : nil, height: isMacOS() ? getRectangle().height - 180 : nil, alignment: .leading)
        .background(Color("background").ignoresSafeArea())
        .preferredColorScheme(.light)
    }
    
    @ViewBuilder
    func SideBar() -> some View {
        VStack {
            Text("Pocket")
                .font(.title)
                .fontWeight(.semibold)
            
            // Button
            AddButton()
            
            VStack(spacing: 15) {
                
                let colors = [Color("blue"),Color("green"),Color("orange"),Color("pink"),Color("purple"),Color("yellow")]
                
                ForEach(colors, id: \.self) { c in
                    Circle()
                        .fill(c)
                        .frame(width: 25, height: 25)
                }
            }
            .padding(.top, 25)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.vertical)
        .padding(.horizontal, 22)
        .padding(.top, 35)
    }
    
    @ViewBuilder
    func AddButton() -> some View {
        Button {
            withAnimation {
                isColorShowed.toggle()
            }
        } label: {
             Image(systemName: "plus")
                .font(.title)
                .foregroundColor(.white)
                .padding(isMacOS() ? 12 : 15)
                .background(Color.black)
                .clipShape(Circle())
        }
        .padding(.top, 30)
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

// Extending View

extension View {
    
    func getRectangle() -> CGRect {
        #if os(iOS)
        return UIScreen.main.bounds
        #else
        return NSScreen.main!.visibleFrame
        #endif
    }
    
    func isMacOS() -> Bool {
        #if os(iOS)
        return false
        #endif
        return true
    }
    
}
