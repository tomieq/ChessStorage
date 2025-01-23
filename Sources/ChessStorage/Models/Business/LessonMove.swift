//
//  LessonMove.swift
//  ChessStorage
//
//  Created by Tomasz on 23/01/2025.
//

public struct LessonMove: Codable {
    public let id: String?
    public let updateDate: Double
    public let moveNumber: Int // next move number within lesson
    public let userColor: PieceColor // user's color that moves
    
    // automatic move preceding user's move
    public let fenSimpleBeforeComputerMove: String? // fen fingerprint
    public let fenBeforeComputerMove: String?
    public let computerMove: String?
    
    public let fenSimpleBeforeUserMove: String // fen fingerprint
    public let fenBeforeUserMove: String // to be able to setup pieces just for this move
    public let commentBeforeUserMove: String? // shown to user during learning
    public let commentAfterUserMove: String? // shown to user during learning
    public let correctUserMove: String // correct answer
    public let fenSimpleAfterUserMove: String // fen fingerprint
    public let fenAfterUserMove: String // to be able to setup pieces just after this move
    public let commentOnIncorrectMove: String?
    public let alternativeMoves: [AlternativeMove]? // alternative moves
}

public struct AlternativeMove: Codable {
    public let id: String
    public let pgn: String
    public let comment: String?
}
