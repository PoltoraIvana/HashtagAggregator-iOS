//
//  UIElements.swift
//  Hashtag Aggregator
//
//  Created by Ivan Sobolevskiy on 4/8/17.
//  Copyright © 2017 Ivan Sobolevskiy. All rights reserved.
//

import Foundation
import UIKit

final class HashtagLabel: UILabel, HashtagFontSyle {}
final class UserNameLabel: UILabel, UserNameFontStyle {}
final class NetworkIdLabel: UILabel, NetworkIdFontStyle {}
final class MessageBodyLabel: UILabel, MultilineLabelStyle, BodyFontStyle {}
final class DateLabel: UILabel, NetworkIdFontStyle {}
