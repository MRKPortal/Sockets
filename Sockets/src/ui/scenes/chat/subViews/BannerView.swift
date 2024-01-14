//
//  BannerView.swift
//  Sockets
//
//  Created by Marc Flores on 14/1/24.
//

import SwiftUI

struct BannerView: View {
    
    private let message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    var body: some View {
        Text(message)
            .applyTextStyle(.body)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                Color.blue5
                    .clipShape(
                        RoundedRectangle(cornerSize: .s(8))
                    )
            )
    }
}
