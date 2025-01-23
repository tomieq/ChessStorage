//
//  LessonMoveInfo.swift
//  ChessStorage
//
//  Created by Tomasz on 23/01/2025.
//

public struct LessonMoveInfo: Codable {
    public let id: String?
    public let updateDate: Double
    public let moveNumber: Int
    public let userColor: PieceColor
    
    public let fenSimpleBeforeComputerMove: String?
    public let fenBeforeComputerMove: String?
    public let computerMove: String?
    
    public let fenSimpleBeforeUserMove: String
    public let fenBeforeUserMove: String
    public let commentBeforeUserMove: String?
    public let commentAfterUserMove: String?
    public let correctUserMove: String
    public let fenSimpleAfterUserMove: String
    public let fenAfterUserMove: String
    public let commentOnIncorrectMove: String?
}
