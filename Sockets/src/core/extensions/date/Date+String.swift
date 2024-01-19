//
//  Date+String.swift
//  Sockets
//
//  Created by Marc Flores on 14/1/24.
//

import Foundation

extension Date {
    var friendly: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
}
