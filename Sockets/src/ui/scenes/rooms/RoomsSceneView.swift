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
            //HIVE
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
            }
            //SERVER LABEL
            ZStack {
                Color.clear
                VStack {
                    BannerView(Ls.genericConnectedTo(presenter.server))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                    Spacer()
                }
                .transition(
                    .push(from: .top)
                    .combined(with: .opacity)
                )
                .padding(8)
                .padding(.top, 32)
            }
            
            //BUTTONS
            VStack {
                Spacer()
                HStack {
                    IconCircularAppButton(
                        .iconsLeft,
                        style: .destructive,
                        padding: 0,
                        action: presenter.didTapLogout
                    )
                    .frame(size: .s(56))

                    Spacer()

                    IconCircularAppButton(
                        .iconsPlus,
                        style: .normal,
                        action: presenter.didTapAdd
                    )
                    .frame(size: .s(64))
                }
                .padding(.horizontal, 32)
            }
        }
        .feedbackSystem(presenter.feedbackPublisher)
        .onAppear(perform: presenter.connect)
    }
}
