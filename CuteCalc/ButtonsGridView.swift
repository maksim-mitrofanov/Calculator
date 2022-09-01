//
//  ButtonsGridView.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 31.08.2022.
//

import SwiftUI

struct ButtonsGridView: View {
    let screenWidth = UIScreen.main.bounds.width
    let buttons = ButtonStorage().buttons
    
    var body: some View {
        MainButtonGrid(buttons: buttons, width: screenWidth)
            .overlay(
                ZStack {
                    ZeroButton(width: screenWidth)
                    EqualsButton(width: screenWidth)
                }
            )
    }
    
    struct EqualsButton: View {
        var width: CGFloat
        
        var body: some View {
            GeometryReader { geometry in
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                        Rectangle()
                            .frame(width: width / 5)
                            .frame(height: geometry.size.height * 0.4 - 4)
                            .cornerRadius(5)
                            .overlay(
                                Text("=")
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                            )
                    }
                }
            .opacity(0.3)
            }
        }
    }
    
    struct ZeroButton: View {
        var width: CGFloat
        
        var body: some View {
            GeometryReader { geometry in
            VStack {
                Spacer()
                
                HStack {
                        Rectangle()
                            .frame(width: geometry.size.width / 2 - 4)
                            .frame(height: width / 5)
                            .cornerRadius(5)
                            .overlay(
                                Text("0")
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                            )
                    }
                }
            .opacity(0.3)
            }
        }
    }
    
    struct MainButtonGrid: View {
        let buttons: [[String]]
        let width: CGFloat
        
        var body: some View {
            VStack(alignment: .leading) {
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { buttonText in
                            SingleButtonView(text: buttonText, width: width)
                        }
                    }
                }
            }
        }
    }
    
    struct SingleButtonView: View {
        let text: String
        let width: CGFloat
        
        var body: some View {
            Rectangle()
                .foregroundColor(.gray.opacity(0.1))
                .frame(width: width / 5, height: width / 5)
            
                .overlay(
                    Text(text)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                )
                .cornerRadius(5)
//                .opacity(text != "" ? 1 : 0)
        }
    }
}

struct ButtonGrid_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsGridView()
    }
}
