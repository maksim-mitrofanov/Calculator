//
//  ButtonLayoutValues.swift
//  Calculator
//
//  Created by Максим Митрофанов on 18.09.2022.
//

import SwiftUI
import Foundation

struct ButtonLayoutValues {
    static let PortraitVerticalSpaceToButtonWidthRatio: CGFloat = 5.1
    static let PortraitVerticalSpaceToButtonHeightRatio: CGFloat = 5.1

    static let LandscapeVerticalSpaceToButtonWidthRatio: CGFloat = 5
    static let LandscapeVerticalSpaceToButtonHeightRatio: CGFloat = 6

    static let VerticalSpaceToVerticalSpacingRatio: CGFloat = 45
    static let VerticalSpaceToHorizontalSpacingRatio: CGFloat = 35

}


enum ThemeOption {
    case auto, alwaysDark, alwaysLight
}
