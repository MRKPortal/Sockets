//
//  NgonShape.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import SwiftUI

struct NgonShape: Shape {

    let points: Int
    
    func path(in rect: CGRect) -> Path {
        let radius = rect.size/2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let floatTotal = CGFloat(points)
        var path = Path()
        (0..<points).forEach { point in
            let floatPoint = CGFloat(point)
            let radians = floatPoint * (2 * .pi) / floatTotal + (.pi / 2)
            let coords = center + CGPoint(
                x: radius.width * cos(radians),
                y: radius.height * sin(radians)
            )
            
            if point == 0 {
                path.move(to: coords)
            } else {
                path.addLine(to: coords)
            }
        }

        path.closeSubpath()
        return path
    }
}
