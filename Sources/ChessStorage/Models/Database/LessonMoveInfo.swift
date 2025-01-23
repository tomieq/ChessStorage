//
//  LessonMoveInfo.swift
//  ChessStorage
//
//  Created by Tomasz on 23/01/2025.
//

public struct LessonMoveInfo: Codable {
    public let id: String?
    public let lessonID: String
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
    
    public init(id: String? = nil, lessonID: String, updateDate: Double, moveNumber: Int, userColor: PieceColor,
                fenSimpleBeforeComputerMove: String?, fenBeforeComputerMove: String?, computerMove: String?,
                fenSimpleBeforeUserMove: String, fenBeforeUserMove: String, commentBeforeUserMove: String?,
                commentAfterUserMove: String?, correctUserMove: String, fenSimpleAfterUserMove: String,
                fenAfterUserMove: String, commentOnIncorrectMove: String?) {
        self.id = id
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
