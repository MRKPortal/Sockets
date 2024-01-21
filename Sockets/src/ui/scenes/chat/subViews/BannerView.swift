//
//  BannerView.swift
//  Sockets
//
//  Created by Marc Flores on 14/1/24.
//

import SwiftUI

struct BannerView: View {
    
    private let message: String
    private let color: Color

    init(_ message: String, color: Color = .blue0) {
        self.message = message
        self.color = color
    }
    
    var body: some View {
        Text(message)
            .applyTextStyle(.body)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                color
                    .clipShape(
                        RoundedRectangle(cornerSize: .s(8))
                    )
            )
    }
}
