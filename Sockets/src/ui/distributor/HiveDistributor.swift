//
//  HiveDistributor.swift
//  Sockets
//
//  Created by Marc Flores on 15/1/24.
//

import CoreGraphics

public class HiveDistributor: DistributorProtocol {

    public var positionGroups: [DistributorPosition] = [[.zero]]
    
    public init(horizontal: Int, vertical: Int) {
        calculatePositions(
            horizontal: horizontal,
            vertical: vertical
        )
    }
}

extension HiveDistributor {
    func calculatePositions(horizontal: Int, vertical: Int) {
        let width = abs(cos(Double.pi/3))
        let height = abs(sin(Double.pi/3))

        var evenVector: [CGPoint] = [.zero]
        var pairVector: [CGPoint] = []

        for column in (0..<horizontal) {
            //EVEN
            let dist = 2*Double(column + 1)
            evenVector.append(.p(-width * dist, 0))
            evenVector.append(.p(width * dist, 0))

            //PAIR
            pairVector.append(.p(1 - (dist + 1) * width, height))
            pairVector.append(.p((dist + 1) * width - 1, height))
            pairVector.append(.p(1 - (dist + 1) * width, -height))
            pairVector.append(.p((dist + 1) * width - 1, -height))
        }
        
        var totalVector: [CGPoint] = pairVector + evenVector
        for row in (1..<vertical) {
            let dist = CGFloat(row) * 2*height
            totalVector += evenVector.map { $0 + .p(0, dist) }
            totalVector += evenVector.map { $0 + .p(0, -dist) }
            totalVector += pairVector.map { $0 + .p(0, dist) }
            totalVector += pairVector.map { $0 + .p(0, -dist) }
        }
        
        positionGroups = (0...vertical + 1).map { radius in
            let lowerBound = Double(radius) - 0.5
            let upperBound = Double(radius) + 0.5
            return totalVector.filter { vector in
                let distance = sqrt(vector.x * vector.x + vector.y * vector.y)
                return lowerBound < distance && upperBound > distance
            }
        }
    }
}
