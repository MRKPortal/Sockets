//
//  Publisher+AssignWeak.swift
//  Sockets
//
//  Created by Marc Flores on 21/1/24.
//

import Combine

public extension Publisher where Failure == Never {
    func assign<Root: AnyObject>(
        to keyPath: ReferenceWritableKeyPath<Root, Output>,
        onWeak object: Root
    ) -> AnyCancellable {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}
