//
//  File.swift
//  markDownKit
//
//  Created by assaf yehudai on 9/25/17.
//  Copyright © 2017 assaf yehudai. All rights reserved.
//

import Foundation
import AppKit

let none = NSFont.systemFont(ofSize: 16)
let bold = NSFont.boldSystemFont(ofSize: 16)
let italic = NSFont(name: "Helvetica-LightOblique", size: 15)
let boldItalic = NSFont(name: "Helvetica-BoldOblique", size: 16)
let code = NSFont(name: "Courier", size: 14)

extension MarkDown {
    
    func attributesFor(_ style: MarkStyles) -> [String: AnyObject] {
        switch style {
        case .bold:
            return [NSFontAttributeName: bold]
        case .italic:
            return [NSFontAttributeName: italic!]
        case .boldItalic:
            return [NSFontAttributeName: boldItalic!]
        case .code:
            return [NSFontAttributeName: code!,
                    NSForegroundColorAttributeName: NSColor.codeForeground]
        default:
            return [NSFontAttributeName: none]
        }
    }

}
