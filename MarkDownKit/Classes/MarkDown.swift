//
//  MarkDownManager.swift
//  String Attributes test
//
//  Created by assaf yehudai on 9/15/17.
//  Copyright © 2017 assaf yehudai. All rights reserved.
//

import Foundation

#if os(iOS)
    import UIKit
    
    public typealias OSFont = UIFont
    public typealias OSColor = UIColor
    
#elseif os(macOS)
    import Cocoa
    import AppKit
    
    public typealias OSFont = NSFont
    public typealias OSColor = NSColor
    
#endif

public class MarkDown {
    
    private var text: String!
    private var attrText: NSMutableAttributedString!
    private let fonts: Fonts!
    
    // MARK: - Init
    
    public init(string: String, fontsSize: CGFloat) {
        text =  string
        self.fonts = Fonts(fontsSize: fontsSize)
        attrText = NSMutableAttributedString(string: text, attributes: [NSFontAttributeName:  fonts.regular])
    }
    
    // MARK: - Public Marking Functions
    
    public func markDown() -> NSAttributedString {
        var components = getMarkDownComponents(.code)
        updateAtterbutedTextFrom(components)
        
        components = getMarkDownComponents(.bold)
        updateAtterbutedTextFrom(components)
        
        components = getMarkDownComponents(.italic)
        updateAtterbutedTextFrom(components)
        
        components = getMarkDownComponents(.strikeThrough)
        updateAtterbutedTextFrom(components)
        
        checkForLinks()
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
        
        guard textSize != 0 else {
            return components
        }
        
        for index in 0..<textSize {
            closeIndex = index
            guard String(text[index]) == style.rawValue && charFontAttributeAt(index) != fonts.code else {
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
    
    private func checkForLinks() {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
        for match in matches {
            guard let range = Range(match.range, in: text) else { continue }
            if let url  = URL(string: text[range]) {
                attrText.addAttribute(NSLinkAttributeName, value: url, range: text.nsRange(from: range))
            }
        }
    }
    
    // MARK: - Attributes Applying
    
    private func getMutableAttrString(lowerB: Int, upperB: Int, style: MarkStyles) -> NSMutableAttributedString {
        
        let nsRangeLength = upperB - lowerB
        let range = NSMakeRange(lowerB, nsRangeLength)
        
        switch style {
        case .strikeThrough:
            attrText.addAttributes(attributesFor(.strikeThrough), range: range)
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
                    case fonts.regular:
                        attrText.setAttributes(attributesFor(style), range: charRange)
                    case fonts.code:
                        continue
                    default:
                        attrText.setAttributes(attributesFor(.boldItalic), range: charRange)
                    }
                }
            }
        }
        
        let res = attrText.attributedSubstring(from: range)
        return NSMutableAttributedString(attributedString: res)
    }
    
    private func attributesFor(_ style: MarkStyles) -> [String: Any] {
        switch style {
        case .bold:
            return [NSFontAttributeName: fonts.bold]
        case .italic:
            return [NSFontAttributeName: fonts.italic]
        case .boldItalic:
            return [NSFontAttributeName: fonts.boldItalic!]
        case .code:
            return [NSFontAttributeName: fonts.code!,
                    NSForegroundColorAttributeName: OSColor.codeForeground]
        case .strikeThrough:
            return [NSStrikethroughStyleAttributeName: 1,
                    NSStrikethroughColorAttributeName: OSColor.black]
        default:
            return [NSFontAttributeName: fonts.regular]
        }
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
    
    private func charFontAttributeAt(_ index: Int) -> OSFont? {
        
        let charAttributes = attrText.attributes(at: index, effectiveRange: nil)
        return charAttributes[NSFontAttributeName] as? OSFont
    }
    
}

