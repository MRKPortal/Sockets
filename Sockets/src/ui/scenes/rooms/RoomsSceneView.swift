//
//  RoomsSceneView.swift
//  Sockets
//
//  Created by Marc Flores on 15/1/24.
//

import SwiftUI

struct RoomsSceneView<P: RoomsScenePresenterProtocol>: View {
    
    private let generator = UIImpactFeedbackGenerator(style: .light)
    
    @ObservedObject private var presenter: P
    
    init(_ presenter: P) {
        self.presenter = presenter
    }
    
    var body: some View {
        ZStack {
            GeometryReader { reader in
                HiveView { index, pos in
                    RoomCellView(presenter.rooms[secured: index])
                        .frame(size: .s(reader.size.width/3))
                        .onTapGesture {
                            generator.impactOccurred()
                        }
                }

                ZStack(alignment: .bottomTrailing) {
                    Color.clear
                    IconCircularAppButton(.iconsPlus) {
                        
                    }
                    .frame(size: .s(56))
                    .padding(32)
                }
            }
        }
    }
}
