//
//  PieceColor.swift
//  ChessStorage
//
//  Created by Tomasz on 23/01/2025.
//

public enum PieceColor: String, Codable {
    case white
    case black
    
    public var other: PieceColor {
        switch self {
        case .white:
            .black
        case .black:
            .white
        }
    }
}
