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
        #if os(macOS)
        .ignoresSafeArea()
        #endif
        .frame(width: isMacOS() ? getRectangle().width / 1.7 : nil, height: isMacOS() ? getRectangle().height - 180 : nil, alignment: .leading)
        .background(Color("background").ignoresSafeArea())
        #if os(iOS)
        .overlay(SideBar())
        #endif
        .preferredColorScheme(.light)
    }
    
    @ViewBuilder
    func MainContent() -> some View {
        VStack(spacing: 8) {
            
            // Search Bar
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                TextField("Search", text: .constant(""))
                    .background(Color.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, isMacOS() ? 0 : 10)
            .overlay(
                Rectangle()
                    .fill(Color.gray.opacity(0.15))
                    .frame(height: 1)
                    .padding(.horizontal, -25)
                    .offset(y: 8),
                alignment: .bottom
            )
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 15) {
                    Text("Notes")
                        .font(isMacOS() ? .system(size: 33, weight: .bold) : .largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Columns
                    
                    let columns = Array(repeating: GridItem(.flexible(),spacing: isMacOS() ? 25 : 15), count: isMacOS() ? 3 : 1)
                    
                    LazyVGrid(columns: columns,spacing: 25) {
                        ForEach(notes) { notes in
                        
                            // Card
                            CardView(note: notes)
                        }
                    }
                    .padding(.top, 30)
                }
                .padding(.top, isMacOS() ? 45 : 30)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, isMacOS() ? 25 : 0)
        .padding(.horizontal, 25)
    }
    
    @ViewBuilder
    func CardView(note: Note) -> some View {
        VStack {
            Text(note.note)
                .font(isMacOS() ? .title3 : .body)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text(note.date, style: .date)
                    .foregroundColor(.black)
                    .opacity(0.9)
                
                Spacer(minLength: 0)
                
                // Edit button
                Button {
                    
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 15, weight: .bold))
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .clipShape(Circle())
                }
            }
            .padding(.top, 55)
        }
        .padding()
        .background(note.cardColor)
        .cornerRadius(15)
    }
    
    @ViewBuilder
    func SideBar() -> some View {
        VStack {
            if isMacOS() {
            Text("Notepad +")
                .font(.title)
                .fontWeight(.semibold)
            }
            // Button
            if isMacOS() {
            AddButton()
                .zIndex(1)
            }
            VStack(spacing: 15) {
                
                let colors = [Color("blue"),Color("green"),Color("orange"),Color("pink"),Color("purple"),Color("yellow")]
                
                ForEach(colors, id: \.self) { c in
                    Circle()
                        .fill(c)
                        .frame(width: isMacOS() ? 20 : 25, height: isMacOS() ? 20 : 25)
                }
            }
            .padding(.top, 25)
            .frame(height: isColorShowed ? nil : 0)
            .opacity(isColorShowed ? 1 : 0)
            .zIndex(0)
            
            if !isMacOS() {
                AddButton()
                    .zIndex(1)
            }
        }
        #if os(macOS)
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.vertical)
        .padding(.horizontal, 22)
        .padding(.top, 35)
        #else
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottomTrailing)
        .padding()
        // Bluring
        .background(
            BlurView(style: .systemUltraThinMaterialDark).ignoresSafeArea()
                .opacity(isColorShowed ? 1 : 0)
                .ignoresSafeArea()
        )
        #endif
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
