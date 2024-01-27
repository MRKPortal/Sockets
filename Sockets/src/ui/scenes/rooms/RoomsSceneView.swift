//
//  RoomsSceneView.swift
//  Sockets
//
//  Created by Marc Flores on 15/1/24.
//

import SwiftUI

struct RoomsSceneView<P: RoomsScenePresenterProtocol>: View {
    
    @State private var state: ConnectionState?
    @State private var animate: Bool = false
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
                        .accessibilityIdentifier(Identifiers.Rooms.roomCell(index))
                        .onTapGesture {
                            if let room {
                                UI.Feedback.buttonHaptic.impactOccurred()
                                presenter.didTap(room: room)
                            }
                        }
                }
            }
            //SERVER LABEL
            ZStack(alignment: .topTrailing) {
                Color.clear
                ConnectionView(
                    publisher: presenter.connectionPublisher,
                    url: presenter.server
                )
            }
            .padding(16)
            .offset(x: animate ? 0 : -100)
            .opacity(animate ? 1 : 0)
            
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
                    .accessibilityIdentifier(Identifiers.Rooms.logoutBtn)
                    .frame(size: .s(56))
                    .offset(x: animate ? 0 : -100)
                    .opacity(animate ? 1 : 0)
                    
                    Spacer()
                    
                    IconCircularAppButton(
                        .iconsPlus,
                        style: .normal,
                        action: presenter.didTapAdd
                    )
                    .accessibilityIdentifier(Identifiers.Rooms.addBtn)
                    .frame(size: .s(64))
                    .offset(x: animate ? 0 : 100)
                    .opacity(animate ? 1 : 0)
                }
                .padding(.horizontal, 32)
            }
        }
        .feedbackSystem(presenter.feedbackPublisher)
        .onAppear {
            presenter.connect()
            withAnimation(.bouncy(duration: 1, extraBounce: 0.25).delay(1.75)) {
                animate.toggle()
            }
        }
    }
}
