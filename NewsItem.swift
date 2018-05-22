//
//  NewsItem.swift
//  StretchMyHead
//
//  Created by Tyler Boudreau on 2018-05-21.
//  Copyright © 2018 Tyler Boudreau. All rights reserved.
//

import Foundation
import UIKit

struct NewsItem {
    
    let category: NewsCategory
    let headline: String
}

enum NewsCategory {
    case World
    case Americas
    case Europe
    case MiddleEast
    case Africa
    case AsiaPacific
    
    func toString() -> String {
        switch self {
        case .World:
            return "World"
        case .Americas:
            return "Americas"
        case .Europe:
            return "Europe"
        case .Africa:
            return "Africa"
        case .MiddleEast:
            return "Middle East"
        case . AsiaPacific:
            return "Asia-Pacific"
        }
    }
    
    func toColor() -> UIColor {
        switch self {
        case .World:
            return UIColor.red
        case . Americas:
            return UIColor.blue
        case .Europe:
            return UIColor.green
        case .Africa:
            return UIColor.orange
        case.MiddleEast:
            return UIColor.yellow
        case.AsiaPacific:
            return UIColor.purple
        }
    }
}
