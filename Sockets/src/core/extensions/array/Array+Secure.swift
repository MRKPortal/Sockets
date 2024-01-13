//
//  Array+Secure.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import Foundation

extension Array {
    subscript(secured index: Int?) -> Element? {
        guard let index, index > -1 && index < count else {
            return nil
        }
        return self[index]
    }
}
