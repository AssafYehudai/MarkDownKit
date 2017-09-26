//
//  FontsAndMarkStyle.swift
//  Pods
//
//  Created by assaf yehudai on 9/26/17.
//
//

import Foundation

// MARK: - Mark Styles

public enum MarkStyles : String {
    case bold       = "*"
    case italic     = "_"
    case code       = "`"
    case link       = "["
    case boldItalic
    case none
}

// MARK: - Fonts

public struct Fonts {
    
    var regular: OSFont!
    var bold: OSFont!
    var italic: OSFont!
    var boldItalic: OSFont!
    var code: OSFont!
    
    public init(fontsSize: CGFloat) {
        regular = OSFont.systemFont(ofSize: fontsSize)
        bold = OSFont.boldSystemFont(ofSize: fontsSize)
        italic = OSFont(name: "Helvetica-LightOblique", size: fontsSize - 1)!
        boldItalic = OSFont(name: "Helvetica-BoldOblique", size: fontsSize)!
        code = OSFont(name: "Courier", size: fontsSize - 2)!
    }    
}

