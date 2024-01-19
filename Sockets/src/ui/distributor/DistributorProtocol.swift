//
//  DistributorProtocol.swift
//  Sockets
//
//  Created by Marc Flores on 15/1/24.
//

import CoreGraphics

public typealias DistributorPosition = [CGPoint]

public protocol DistributorProtocol {
    var positionGroups: [DistributorPosition] { get }
    func index(group: Int, index: Int) -> Int?
}

extension DistributorProtocol {
    public func index(group: Int, index: Int) -> Int? {
        guard group < positionGroups.count,
              index < positionGroups[group].count else {
            return nil
        }
        
        var output = 0
        var currentGroup = 0
        while currentGroup < group {
            output += positionGroups[currentGroup].count
            currentGroup += 1
        }

        return output + index
    }
}
