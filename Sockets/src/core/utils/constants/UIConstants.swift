//
//  UIConstants.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import SwiftUI

enum UI {
    enum Hive {
        static let hiveElementWidth = 12

        static let distributor = HiveDistributor(
            horizontal: 2,
            vertical: 2
        )
    }

    enum Messages {
        static let colors: [Color] = [
            .red5,
            .green5,
            .blue3,
            .green2,
            .orange2,
            .orange2,
            .red2,
            .sky5,
            .sky3,
            .yellow5,
            .yellow3
        ]
    }
}
