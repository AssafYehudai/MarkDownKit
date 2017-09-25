//
//  MarkDownManager.swift
//  String Attributes test
//
//  Created by assaf yehudai on 9/15/17.
//  Copyright © 2017 assaf yehudai. All rights reserved.
//

import Foundation

let TEXT = "`*_Lorem ipsum dolor_* sit er elit lamet, consectetaur *cillium adipisicing pecu, *sed` do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,*quis nostrud* exercitation ullamco laboris nisi `ut aliquip ex ea commodo consequat.` Duis aute irure *dolor in _reprehenderit* in voluptate_ velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, _sunt in culpa_ qui officia deserunt mollit anim id est laborum. Nam liber te *conscient to factor* tum poen legum odioque civiuda."


class MarkDown {
    
    private var text: String!
    private var attrText: NSMutableAttributedString!
    
    // MARK: - Mark Styles
    
    enum MarkStyles : String {
        case bold       = "*"
        case italic     = "_"
        case code       = "`"
        case link       = "["
        case boldItalic
        case none
    }
    
    // MARK: - Init
    
    init(string: String) {
        text =  string
        attrText = NSMutableAttributedString(string: text, attributes: [NSFontAttributeName:  none])
    }
    
    // MARK: - Public Marking Functions
    
    func markDown() -> NSAttributedString {
        var components = getMarkDownComponents(.code)
        updateAtterbutedTextFrom(components)
        
        components = getMarkDownComponents(.bold)
        updateAtterbutedTextFrom(components)
        
        components = getMarkDownComponents(.italic)
        updateAtterbutedTextFrom(components)
        
        return attrText
    }
    
    // MARK: - Text Parsing
    
    private func updateAtterbutedTextFrom (_ components: [NSMutableAttributedString]) {
        let newAttributedText = NSMutableAttributedString()
        for comp in components {
            newAttributedText.append(comp)
        }
        attrText = newAttributedText
        text = attrText.string
    }
    
    private func getMarkDownComponents (_ style: MarkStyles) -> [NSMutableAttributedString] {
        var components = [NSMutableAttributedString]()
        var openIndex = 0
        var closeIndex = 0
        var lookingForClosingMark = false
        let textSize = text.characters.count
        
        for index in 0..<textSize {
            closeIndex = index
            guard String(text[index]) == style.rawValue && charFontAttributeAt(index) != code else {
                continue
            }
            if isClosingMarkAt(index, mark: style.rawValue) && lookingForClosingMark {
                lookingForClosingMark = false
                components.append(getMutableAttrString(lowerB: openIndex + 1, upperB: index, style: style))
                openIndex = index + 1
            } else if isOpenMarkAt(index, mark: style.rawValue) {
                guard index != openIndex else {
                    components.append(NSMutableAttributedString(string: ""))
                    lookingForClosingMark = true
                    continue
                }
                components.append(getMutableAttrString(lowerB: openIndex, upperB: index, style: .none))
                openIndex = index
                lookingForClosingMark = true
            }
        }
        components.append(getMutableAttrString(lowerB: openIndex, upperB: closeIndex + 1, style: .none))
        return components
    }

    // MARK: - Attributes Applying
    
    private func getMutableAttrString(lowerB: Int, upperB: Int, style: MarkStyles) -> NSMutableAttributedString {
        
        let nsRangeLength = upperB - lowerB
        let range = NSMakeRange(lowerB, nsRangeLength)
        
        switch style {
        case .code:
            attrText.setAttributes(attributesFor(.code), range: range)
        case .none:
            break
        default:
            for i in lowerB...upperB {
                let charRangeLength = 1
                let charRange = NSMakeRange(i, charRangeLength)
                
                if let font = charFontAttributeAt(i) {
                    switch font {
                    case none:
                        attrText.setAttributes(attributesFor(style), range: charRange)
                    default:
                        attrText.setAttributes(attributesFor(.boldItalic), range: charRange)
                    }
                }
            }
        }
        
        let res = attrText.attributedSubstring(from: range)
        return NSMutableAttributedString(attributedString: res)
    }
    
    // MARK: - Open/Close Mark Check
    
    private func isOpenMarkAt(_ index: Int, mark: String) -> Bool {
        guard index < text.characters.count else {
            return false
        }
        return String(text[index + 1]) != mark && text[index + 1] != " "
    }
    
    private func isClosingMarkAt(_ index: Int, mark: String) -> Bool {
        
        guard index > 0 else {
            return false
        }
        return String(text[index - 1]) != mark && text[index - 1] != " "
    }
    
    private func charFontAttributeAt(_ index: Int) -> UIFont? {
        
        let charAttributes = attrText.attributes(at: index, effectiveRange: nil)
        return charAttributes[NSFontAttributeName] as? UIFont
    }
}


// ----- debug indication code -----
// #################################

//let lowerBound = text.index(at: lowerB)
//let upperBound = text.index(at: upperB)
//let range = Range(uncheckedBounds: (lowerBound, upperBound))
//print("res from text: - " + text.substring(with: range))

