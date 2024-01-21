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
            vertical: 3
        )
    }

    enum Feedback {
        static let buttonHaptic = UIImpactFeedbackGenerator(style: .light)
    }
    
    enum Colors {
        static let options: [Color] = [
            .red5,
            .yellow3,
            .blue3,
            .green5,
            .orange2,
            .yellow5,
            .red2,
            .green2,
            .sky5
        ]
    }
}
