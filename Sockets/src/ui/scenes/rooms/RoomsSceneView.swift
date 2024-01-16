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
                    let room = presenter.rooms[secured: index]
                    RoomCellView(room)
                        .frame(size: .s(reader.size.width/4))
                        .allowsHitTesting(room != nil)
                        .onTapGesture {
                            if let room {
                                generator.impactOccurred()
                                presenter.didTap(room: room)
                            }
                        }
                }
                
                ZStack(alignment: .bottomTrailing) {
                    Color.clear
                    IconCircularAppButton(.iconsPlus, action: presenter.didTapAdd)
                        .frame(size: .s(56))
                        .padding(.trailing, 32)
                }
            }
        }
    }
}
