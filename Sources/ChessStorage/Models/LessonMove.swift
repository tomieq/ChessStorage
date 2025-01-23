//
//  LessonMoveInfo.swift
//  ChessStorage
//
//  Created by Tomasz on 23/01/2025.
//
import Foundation

public struct LessonMove: Codable {
    public let id: String
    public let lessonID: String
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
    
    public init(id: String? = nil, lessonID: String, updateDate: Double, moveNumber: Int, userColor: PieceColor,
                fenSimpleBeforeComputerMove: String?, fenBeforeComputerMove: String?, computerMove: String?,
                fenSimpleBeforeUserMove: String, fenBeforeUserMove: String, commentBeforeUserMove: String?,
                commentAfterUserMove: String?, correctUserMove: String, fenSimpleAfterUserMove: String,
                fenAfterUserMove: String, commentOnIncorrectMove: String?) {
        self.id = id ?? UUID().uuidString
        self.lessonID = lessonID
        self.updateDate = updateDate
        self.moveNumber = moveNumber
        self.userColor = userColor
        self.fenSimpleBeforeComputerMove = fenSimpleBeforeComputerMove
        self.fenBeforeComputerMove = fenBeforeComputerMove
        self.computerMove = computerMove
        self.fenSimpleBeforeUserMove = fenSimpleBeforeUserMove
        self.fenBeforeUserMove = fenBeforeUserMove
        self.commentBeforeUserMove = commentBeforeUserMove
        self.commentAfterUserMove = commentAfterUserMove
        self.correctUserMove = correctUserMove
        self.fenSimpleAfterUserMove = fenSimpleAfterUserMove
        self.fenAfterUserMove = fenAfterUserMove
        self.commentOnIncorrectMove = commentOnIncorrectMove
    }
}
