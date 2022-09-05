//
//  ButtonStorage.swift
//  CuteCalc
//
//  Created by Максим Митрофанов on 01.09.2022.
//

import Foundation


class ButtonStorage {
    var buttonsWithData: [CalculatorButtonData] = [
        CalculatorButtonData(text: "AC"), CalculatorButtonData(text: "-"), CalculatorButtonData(text: "+"), CalculatorButtonData(text: "M"),
        CalculatorButtonData(text: "7"), CalculatorButtonData(text: "8"), CalculatorButtonData(text: "9"), CalculatorButtonData(text: "*"),
        CalculatorButtonData(text: "4"), CalculatorButtonData(text: "5"), CalculatorButtonData(text: "6"), CalculatorButtonData(text: "/"),
        CalculatorButtonData(text: "1"), CalculatorButtonData(text: "2"), CalculatorButtonData(text: "3"),
        CalculatorButtonData(text: "=", aspectRatio: 2/1), CalculatorButtonData(text: "0", aspectRatio: 1/2), CalculatorButtonData(text: ".")
    ]
}
