//
//  CoreGraphics+Init.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import CoreGraphics
import SwiftUI

extension CGSize {
    static func s(w: CGFloat = 0, h: CGFloat = 0) -> Self {
        .init(width: w, height: h)
    }
    
    static func s(_ side: CGFloat) -> Self {
        .s(w: side, h: side)
    }

    static func angle(_ angle: Angle) -> Self {
        .init(
            width: cos(angle.radians),
            height: sin(angle.radians)
        )
    }
}

extension CGAffineTransform {
    static func t(_ x: CGFloat, y: CGFloat) -> Self {
        .init(translationX: x, y: y)
    }

    static func t(_ p: CGPoint) -> Self {
        .init(translationX: p.x, y: p.y)
    }
    
    static func s(_ scale: CGFloat) -> Self {
        .init(scaleX: scale, y: scale)
    }
}

extension CGPoint {
    static func p(_ x: CGFloat, _ y: CGFloat) -> Self {
        .init(x: x, y: y)
    }
    
    static func angle(_ angle: Angle) -> Self {
        .init(
            x: cos(angle.radians),
            y: sin(angle.radians)
        )
    }
}
