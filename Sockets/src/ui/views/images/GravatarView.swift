//
//  GravatarView.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import SwiftUI

struct GravatarView: View {
    
    private let identifier: String
    
    init(_ identifier: String) {
        self.identifier = identifier
    }

    var body: some View {
        GeometryReader { reader in
            CacheAsyncImage(url: url(size: reader.size.width)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                default:
                    Color.base3
                }
            }
            .clipShape(Circle())
        }
    }
    
    private func url(size: CGFloat) -> URL {
        let size = Int(size)
        return URL(string: "https://www.gravatar.com/avatar/\(identifier)?s=\(size)&d=identicon&r=g")!
    }
}
