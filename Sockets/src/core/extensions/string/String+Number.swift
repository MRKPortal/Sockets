//
//  String+Number.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import Foundation

public extension String {
    var number: Int {
        bytes.reduce(0) { result, value in
            result + Int(value)
        }
    }
}
