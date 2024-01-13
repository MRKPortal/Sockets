//
//  TextStyle.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import SwiftUI

enum TextStyle {
    case h1, h2, h4
    case body
    
    //MARK: Attributes
    
    var font: Font {
        switch self {
        case .h1: .montserrat_20_600
        case .h2: .montserrat_20_600
        case .h4: .montserrat_16_600
        case .body: .montserrat_14_400
        }
    }
    
    var lineSpacing: CGFloat {
        switch self {
            ///Line height: 22px, Font size: 20px
        case .h1: (22 - 20)/2
            ///Line height: 24px, Font size: 20px
        case .h2: (24 - 20)/2
            ///Line height: 24px, Font size: 16px
        case .h4: (24 - 16)/2
            ///Line height: 20px, Font size: 14px
        case .body: (20 - 14)/2
        }
    }
    
    var kern: CGFloat {
        switch self {
        case .h1: 8
        default: 0
        }
    }
}

