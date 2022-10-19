//
//  TextCopiedBanner.swift
//  MagicCalculatorMM
//
//  Created by Максим Митрофанов on 19.10.2022.
//

import SwiftUI

struct TextCopiedBanner: View {
    var numberCopied: String = "123"
    
    var body: some View {
        Text(numberCopied + " was copied to clipboard")
            .padding()
            .background(Color.gray.opacity(0.14))
            .cornerRadius(15)
    }
}

struct TextCopiedBanner_Previews: PreviewProvider {
    static var previews: some View {
        TextCopiedBanner()
    }
}
