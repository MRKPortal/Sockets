//
//  View+TextStyle.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import SwiftUI

extension View {
    func applyTextStyle(_ style: TextStyle, tint: Color = .base2) -> some View {
        font(style.font)
            .foregroundColor(tint)
            .lineSpacing(style.lineSpacing)
            .kerning(style.kern)
    }
}
