//
//  Side.swift
//  Chess
//
//  Created by Rishi Jansari on 21/08/2026.
//

import SwiftUI

enum Side: String {
    case black = "Black"
    case white = "White"
    
    var color: Color {
        switch self {
            case .black:
                .black
            case .white:
                Colors.accentColor
        }
    }
    
    var rotationAngle: Angle {
        switch self {
            case .black:
                    .degrees(180)
            case .white:
                    .degrees(0)
        }
    }
    
    mutating func swap() {
        self = self == .black ? .white : .black
    }
    
    func swapped() -> Side {
        return self == Side.black ? Side.white : Side.black
    }
}
