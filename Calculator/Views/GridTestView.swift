//
//  GridTestView.swift
//  Calculator
//
//  Created by Максим Митрофанов on 18.09.2022.
//

import SwiftUI

struct GridTestView: View {
    let theme: CalculatorTheme
    let isExpanded: Bool
    
    private var rowOne: [CalculatorButtonData] {
        [ CalculatorButtonData(text: "AC"),
          CalculatorButtonData(text: "divide", imageName: "divide"),
          CalculatorButtonData(text: "multiply", imageName: "multiply"),
          CalculatorButtonData(text: "delete", imageName: "delete.backward")]
    }
    
    private var rowTwo: [CalculatorButtonData] { [
        CalculatorButtonData(text: "7"),
        CalculatorButtonData(text: "8"),
        CalculatorButtonData(text: "9"),
        CalculatorButtonData(text: "minus", imageName: "minus")] }
    
    private var rowThree: [CalculatorButtonData] { [
        CalculatorButtonData(text: "4"),
        CalculatorButtonData(text: "5"),
        CalculatorButtonData(text: "6"),
        CalculatorButtonData(text: "plus", imageName: "plus")]
    }
    
    private var rowFour: [CalculatorButtonData] { [
        CalculatorButtonData(text: "1"),
        CalculatorButtonData(text: "2"),
        CalculatorButtonData(text: "3"),
        CalculatorButtonData(text: "")]
    }
    
    private var rowFive: [CalculatorButtonData] { [
        CalculatorButtonData(text: ""),
        CalculatorButtonData(text: ""),
        CalculatorButtonData(text: "."),
        CalculatorButtonData(text: "")
    ]}
    
    private var zeroButtonData: CalculatorButtonData {
        CalculatorButtonData(text: "0", aspectRatio: 1/2)
    }
    
    private var equalsButtonData: CalculatorButtonData {
        CalculatorButtonData(text: "=", aspectRatio: 2/1)
    }
    
    private var rows: [[CalculatorButtonData]] {
        return [rowOne, rowTwo, rowThree, rowFour, rowFive]
    }
    
    private var extaButtonRowData: [CalculatorButtonData] { [
        CalculatorButtonData(imageName: "x.squareroot", aspectRatio: 2/1),
        CalculatorButtonData(text: "^", aspectRatio: 2/1),
        CalculatorButtonData(imageName: "plus.forwardslash.minus", aspectRatio: 2/1),
        CalculatorButtonData(imageName: "percent", aspectRatio: 2/1)]
    }
    
    
    var body: some View {
        VStack {
            extraButtons
            mainButtons
        }
    }
    
    var mainButtons: some View {
        VStack {
            if #available(iOS 16.0, *) {
                Grid {
                    ForEach(rows, id: \.self) { row in
                        GridRow {
                            ForEach(row) { buttonData in
                                Button {
                                    
                                } label: {
                                    CalculatorButtonLabel(buttonData: buttonData, theme: theme)
                                        .aspectRatio(1/1, contentMode: .fit)
                                        .frame(width: ButtonLayout.buttonWidth(for: buttonData))
                                        .frame(height: ButtonLayout.buttonHeight(for: buttonData))
                                        .opacity(buttonData.text == "" ? 0 : 1)
                                }
                            }
                        }
                    }
                }
                .overlay(
                    zeroButton
                )
                .overlay(
                    equalsButton
                )
            } else {
                // Fallback on earlier versions
                Text("")
            }
        }
    }
    
    var zeroButton: some View {
        ZStack {
            VStack {
                Spacer()
                
                HStack{
                    Button {
                        
                    } label: {
                        CalculatorButtonLabel(buttonData: zeroButtonData, theme: theme)
                            .frame(width: ButtonLayout.buttonWidth(for: zeroButtonData))
                            .frame(height: ButtonLayout.buttonHeight(for: zeroButtonData))
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
    var equalsButton: some View {
        ZStack {
            VStack {
                Spacer()
                
                HStack{
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        CalculatorButtonLabel(buttonData: equalsButtonData, theme: theme)
                            .frame(width: ButtonLayout.buttonWidth(for: equalsButtonData))
                            .frame(height: ButtonLayout.buttonHeight(for: equalsButtonData))
                    }
                }
            }
        }
    }
    
    var extraButtons: some View {
        HStack {
            if isExpanded {
                ForEach(extaButtonRowData) { buttonData in
                    Button {

                    } label: {
                        CalculatorButtonLabel(buttonData: buttonData, theme: theme)
                            .frame(width: ButtonLayout.buttonWidth(for: buttonData))
                            .frame(height: ButtonLayout.buttonHeight(for: buttonData))
                    }
                }
            }
        }
    }
}

struct GridTestView_Previews: PreviewProvider {
    static var previews: some View {
        GridTestView(theme: .lightTheme, isExpanded: true)
    }
}
