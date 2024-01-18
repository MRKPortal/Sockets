//
//  Callbacks+Aliases.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import Foundation

typealias VoidCallback = () -> Void
typealias DoubleStringCallback = (String, String) -> Void
typealias MessagesCallback = ([MessageModel]) -> Void
typealias DataCallback = (Data) -> Void
