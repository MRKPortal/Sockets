//
//  GenericToastView.swift
//  Sockets
//
//  Created by Marc Flores on 21/1/24.
//

import SwiftUI

struct GenericToastView: View {
    
    private let message: String
    
    init(message: String) {
        self.message = message
    }
    
    var body: some View {
        Text(message)
            .applyTextStyle(.body, tint: .white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .multilineTextAlignment(.center)
            .background(
                Color.gray2
                    .clipShape(
                        RoundedRectangle(cornerSize: .s(8))
                    )
            )
            .padding(.bottom, 64)
    }
}
