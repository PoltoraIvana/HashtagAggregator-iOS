//
//  AppStyle.swift
//  Hashtag Aggregator
//
//  Created by Ivan Sobolevskiy on 4/8/17.
//  Copyright © 2017 Ivan Sobolevskiy. All rights reserved.
//

import Foundation
import UIKit
import StyleSheet

protocol TitleFontStyle {}
protocol BodyFontStyle {}
protocol MultilineLabelStyle {}
protocol SegmentedControlStyle {}
protocol HashtagFontSyle {}
protocol UserNameFontStyle {}
protocol NetworkIdFontStyle {}
protocol UserAvatarStyle {}

func appStyle(palette: PaletteProtocol) -> StyleProtocol {
    return StyleSheet(styles: [
        /*
         Style<Any, UIView> { // DEBUG
         $0.layer.borderColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2).cgColor
         $0.layer.borderWidth = 1
         },
         */
        
        AppStyle<TitleFontStyle, UILabel> { $0.font = palette.fonts.titleFont },
                
        AppStyle<BodyFontStyle, UILabel> { $0.font = palette.fonts.bodyFont },
        
        AppStyle<MultilineLabelStyle, UILabel> {
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
        },
        
        AppStyle<HashtagFontSyle, UILabel> {
            $0.font = palette.fonts.titleFont
            $0.textColor = UIColor(red: 0/255, green: 153/255, blue: 255/255, alpha: 0.75)
        },
        
        AppStyle<UserNameFontStyle, UILabel> {
            $0.font = palette.fonts.captionFont
            $0.textColor = UIColor.black
        },
        
        AppStyle<NetworkIdFontStyle, UILabel> {
            $0.font = palette.fonts.bodyFont
            $0.textColor = UIColor.darkGray
        }
        ])
}
