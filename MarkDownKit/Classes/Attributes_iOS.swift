//
//  File.swift
//  markDownKit
//
//  Created by assaf yehudai on 9/25/17.
//  Copyright © 2017 assaf yehudai. All rights reserved.
//

import Foundation
import UIKit

let none = UIFont.systemFont(ofSize: 16)
let bold = UIFont.boldSystemFont(ofSize: 16)
let italic = UIFont.italicSystemFont(ofSize: 15)
let boldItalic = UIFont(name: "Helvetica-BoldOblique", size: 16)
let code = UIFont(name: "Courier", size: 14)


extension MarkDown {
    
    func attributesFor(_ style: MarkStyles) -> [String: AnyObject] {
        switch style {
        case .bold:
            return [NSFontAttributeName: bold]
        case .italic:
            return [NSFontAttributeName: italic]
        case .boldItalic:
            return [NSFontAttributeName: boldItalic!]
        case .code:
            return [NSFontAttributeName: code!,
                    NSForegroundColorAttributeName: UIColor.codeForeground]
        default:
            return [NSFontAttributeName: none]
        }
    }
}
