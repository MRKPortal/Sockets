//
//  View+Frame.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func frame(size: CGSize, alignment: Alignment = .center) -> some View {
        frame (
            width: size.width,
            height: size.height,
            alignment: alignment
        )
    }
}

