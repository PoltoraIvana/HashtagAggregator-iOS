//
//  Palette.swift
//  Hashtag Aggregator
//
//  Created by Ivan Sobolevskiy on 4/8/17.
//  Copyright © 2017 Ivan Sobolevskiy. All rights reserved.
//

import UIKit

protocol PaletteProtocol {
    var fonts: FontPaletteProtocol { get }
    var offsets: OffsetPaletteProtocol { get }
}

protocol OffsetPaletteProtocol {
    var xSmall: CGFloat { get }
    var small: CGFloat { get }
}

protocol FontPaletteProtocol {
    var titleFont: UIFont { get }
    var bodyFont: UIFont { get }
    var captionFont: UIFont { get }
    var subtitleFont: UIFont { get }
}

struct DefaultPalette: PaletteProtocol {
    struct DefaultOffsetPalette: OffsetPaletteProtocol {
        let xSmall: CGFloat = 4
        let small: CGFloat = 8
    }
    
    struct DefaultFontPalette: FontPaletteProtocol {
        let titleFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title3)
        let bodyFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        let captionFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
        let subtitleFont = UIFont.systemFont(ofSize: 15)
    }
    
    let fonts: FontPaletteProtocol = DefaultFontPalette()
    let offsets: OffsetPaletteProtocol = DefaultOffsetPalette()
}

