//
//  ButtonStorage.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 01.09.2022.
//

import Foundation


class ButtonStorage: ObservableObject {
    @Published var isExpanded: Bool = false
    
    private let expandImageName = "arrow.up.left.and.arrow.down.right"
    private let collapseImageName = "arrow.down.right.and.arrow.up.left"
    
    var expansionButtonName: String {
        isExpanded ? collapseImageName : expandImageName
    }
    
    var buttonsWithData: [CalculatorButtonData] {[
        //Top Row
        CalculatorButtonData(text: "AC"),
        CalculatorButtonData(text: "/", imageName: "divide"),
        CalculatorButtonData(text: "*", imageName: "multiply"),
        CalculatorButtonData(imageName: "delete.backward"),
        
        //Second Row
        CalculatorButtonData(text: "7"),
        CalculatorButtonData(text: "8"),
        CalculatorButtonData(text: "9"),
        CalculatorButtonData(text: "-", imageName: "minus"),
        
        //Third Row
        CalculatorButtonData(text: "4"),
        CalculatorButtonData(text: "5"),
        CalculatorButtonData(text: "6"),
        CalculatorButtonData(text: "+", imageName: "plus"),
        
        //Fourth Row
        CalculatorButtonData(text: "1"),
        CalculatorButtonData(text: "2"),
        CalculatorButtonData(text: "3"),
        CalculatorButtonData(text: "=", imageName: "equal", aspectRatio: 2/1),
        
        //Bottom Row
        CalculatorButtonData(text: "0", aspectRatio: 1/2),
        CalculatorButtonData(text: ".")
    ]}
}
