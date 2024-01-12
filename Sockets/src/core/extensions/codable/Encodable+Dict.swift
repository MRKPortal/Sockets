//
//  Encodable+Dict.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
            .flatMap { $0 as? [String: Any] }?
            .compactMapValues { $0 }
    }
}
