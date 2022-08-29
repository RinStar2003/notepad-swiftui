//
//  MainView.swift
//  notepad-swiftui (iOS)
//
//  Created by мас on 27.08.2022.
//

import SwiftUI

struct MainView: View {
    
    @State var isColorShowed = false
    @State var isButtonAnimated = false
    
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
            MainContent()
        }
        .ignoresSafeArea()
        .frame(width: isMacOS() ? getRectangle().width / 1.7 : nil, height: isMacOS() ? getRectangle().height - 180 : nil, alignment: .leading)
        .background(Color("background").ignoresSafeArea())
        .preferredColorScheme(.light)
    }
    
    @ViewBuilder
    func MainContent() -> some View {
        VStack(spacing: 15) {
            
            // Search Bar
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                TextField("Search", text: .constant(""))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, isMacOS() ? 0 : 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, isMacOS() ? 25 : 0)
        .padding(.horizontal, 25)
    }
    
    @ViewBuilder
    func SideBar() -> some View {
        VStack {
            Text("Notepad +")
                .font(.title)
                .fontWeight(.semibold)
            
            // Button
            AddButton()
                .zIndex(1)
            
            VStack(spacing: 15) {
                
                let colors = [Color("blue"),Color("green"),Color("orange"),Color("pink"),Color("purple"),Color("yellow")]
                
                ForEach(colors, id: \.self) { c in
                    Circle()
                        .fill(c)
                        .frame(width: 25, height: 25)
                }
            }
            .padding(.top, 25)
            .frame(height: isColorShowed ? nil : 0)
            .opacity(isColorShowed ? 1 : 0)
            .zIndex(0)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.vertical)
        .padding(.horizontal, 22)
        .padding(.top, 35)
    }
    
    @ViewBuilder
    func AddButton() -> some View {
        Button {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                isColorShowed.toggle()
                isButtonAnimated.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring()) {
                    isButtonAnimated.toggle()
                }
            }
            
        } label: {
             Image(systemName: "plus")
                .font(.title)
                .foregroundColor(.white)
                .scaleEffect(isButtonAnimated ? 1.1 : 1)
                .padding(isMacOS() ? 12 : 15)
                .background(Color.black)
                .clipShape(Circle())
        }
        .scaleEffect(isButtonAnimated ? 1.1 : 1)
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

// Hiding Focus Ring
#if os(macOS)
extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get{.none}
        set{}
    }
}
#endif
