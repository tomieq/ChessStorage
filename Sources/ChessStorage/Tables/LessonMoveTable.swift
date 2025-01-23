//
//  LessonMoveTable.swift
//  ChessStorage
//
//  Created by Tomasz KUCHARSKI on 23/01/2025.
//

import Foundation
@preconcurrency import SQLite

enum LessonMoveTable {
    static let name = "lessons"
    static let table = Table(Self.name)
    static let identifier = SQLite.Expression<String>("identifier")
    static let lessonIdentifier = SQLite.Expression<String>("lessonIdentifier")
    static let moveNumber = SQLite.Expression<Int>("moveNumber")
    static let updateDate = SQLite.Expression<Double>("updateDate")
    static let userColor = SQLite.Expression<String>("userColor")
    
    static let fenSimpleBeforeComputerMove = SQLite.Expression<String?>("fenSimpleBeforeComputerMove")
    static let fenBeforeComputerMove = SQLite.Expression<String?>("fenBeforeComputerMove")
    static let computerMove = SQLite.Expression<String?>("computerMove")
    
    static let fenSimpleBeforeUserMove = SQLite.Expression<String>("fenSimpleBeforeUserMove")
    static let fenBeforeUserMove = SQLite.Expression<String>("fenBeforeUserMove")
    static let commentBeforeUserMove = SQLite.Expression<String?>("commentBeforeUserMove")
    static let commentAfterUserMove = SQLite.Expression<String?>("commentAfterUserMove")
    static let correctUserMove = SQLite.Expression<String>("correctUserMove")
    static let fenSimpleAfterUserMove = SQLite.Expression<String>("fenSimpleAfterUserMove")
    static let fenAfterUserMove = SQLite.Expression<String>("fenAfterUserMove")
    static let commentOnIncorrectMove = SQLite.Expression<String?>("commentOnIncorrectMove")
}

extension LessonMoveTable {
    static func createTable(db: Connection) throws {
        try db.run(LessonMoveTable.table.create(ifNotExists: true) { t in
            t.column(LessonMoveTable.identifier)
            t.column(LessonMoveTable.lessonIdentifier)
            t.column(LessonMoveTable.moveNumber)
            t.column(LessonMoveTable.updateDate)
            t.column(LessonMoveTable.userColor)
            t.column(LessonMoveTable.fenSimpleBeforeComputerMove)
            t.column(LessonMoveTable.fenBeforeComputerMove)
            t.column(LessonMoveTable.computerMove)
            t.column(LessonMoveTable.fenSimpleBeforeUserMove)
            t.column(LessonMoveTable.fenBeforeUserMove)
            t.column(LessonMoveTable.commentBeforeUserMove)
            t.column(LessonMoveTable.commentAfterUserMove)
            t.column(LessonMoveTable.correctUserMove)
            t.column(LessonMoveTable.fenSimpleAfterUserMove)
            t.column(LessonMoveTable.fenAfterUserMove)
            t.column(LessonMoveTable.commentOnIncorrectMove)
        })
        try db.run(LessonMoveTable.table.createIndex(LessonMoveTable.identifier, ifNotExists: true))
        try db.run(LessonMoveTable.table.createIndex(LessonMoveTable.lessonIdentifier, ifNotExists: true))
        try db.run(LessonMoveTable.table.createIndex(LessonMoveTable.updateDate, ifNotExists: true))
        try db.run(LessonMoveTable.table.createIndex(LessonMoveTable.fenSimpleBeforeComputerMove, ifNotExists: true))
        try db.run(LessonMoveTable.table.createIndex(LessonMoveTable.fenSimpleBeforeUserMove, ifNotExists: true))
        try db.run(LessonMoveTable.table.createIndex(LessonMoveTable.fenSimpleAfterUserMove, ifNotExists: true))
        try db.run(LessonMoveTable.table.createIndex(LessonMoveTable.moveNumber, ifNotExists: true))
    }
    
    static func count(db: Connection) throws -> Int {
        try db.scalar(LessonMoveTable.table.count)
    }
    
    @discardableResult
    static func store(db: Connection, move: LessonMoveInfo) throws -> LessonMoveInfo {
        var moveIdentifier = ""
        if let identifier = move.id,
           try db.scalar(LessonMoveTable.table.filter(LessonMoveTable.identifier == identifier).count) > 0 {
            moveIdentifier = identifier
            try db.run(LessonMoveTable.table.filter(LessonMoveTable.identifier == identifier).update(
                LessonMoveTable.lessonIdentifier <- lessonIdentifier,
                LessonMoveTable.updateDate <- move.updateDate,
                LessonMoveTable.moveNumber <- move.moveNumber,
                LessonMoveTable.userColor <- move.userColor.rawValue,
                LessonMoveTable.fenSimpleBeforeComputerMove <- move.fenSimpleBeforeComputerMove,
                LessonMoveTable.fenBeforeComputerMove <- move.fenBeforeComputerMove,
                LessonMoveTable.computerMove <- move.computerMove,
                LessonMoveTable.fenSimpleBeforeUserMove <- move.fenSimpleBeforeUserMove,
                LessonMoveTable.fenBeforeUserMove <- move.fenBeforeUserMove,
                LessonMoveTable.commentBeforeUserMove <- move.commentBeforeUserMove,
                LessonMoveTable.commentAfterUserMove <- move.commentAfterUserMove,
                LessonMoveTable.correctUserMove <- move.correctUserMove,
                LessonMoveTable.fenSimpleAfterUserMove <- move.fenSimpleAfterUserMove,
                LessonMoveTable.fenAfterUserMove <- move.fenAfterUserMove,
                LessonMoveTable.commentOnIncorrectMove <- move.commentOnIncorrectMove
            ))
        } else {
            moveIdentifier = move.id ?? UUID().uuidString
            try db.run(LessonMoveTable.table.insert(
                LessonMoveTable.identifier <- moveIdentifier,
                LessonMoveTable.lessonIdentifier <- lessonIdentifier,
                LessonMoveTable.updateDate <- move.updateDate,
                LessonMoveTable.moveNumber <- move.moveNumber,
                LessonMoveTable.userColor <- move.userColor.rawValue,
                LessonMoveTable.fenSimpleBeforeComputerMove <- move.fenSimpleBeforeComputerMove,
                LessonMoveTable.fenBeforeComputerMove <- move.fenBeforeComputerMove,
                LessonMoveTable.computerMove <- move.computerMove,
                LessonMoveTable.fenSimpleBeforeUserMove <- move.fenSimpleBeforeUserMove,
                LessonMoveTable.fenBeforeUserMove <- move.fenBeforeUserMove,
                LessonMoveTable.commentBeforeUserMove <- move.commentBeforeUserMove,
                LessonMoveTable.commentAfterUserMove <- move.commentAfterUserMove,
                LessonMoveTable.correctUserMove <- move.correctUserMove,
                LessonMoveTable.fenSimpleAfterUserMove <- move.fenSimpleAfterUserMove,
                LessonMoveTable.fenAfterUserMove <- move.fenAfterUserMove,
                LessonMoveTable.commentOnIncorrectMove <- move.commentOnIncorrectMove
            ))
        }
        return LessonMoveInfo(id: moveIdentifier,
                              updateDate: move.updateDate,
                              moveNumber: move.moveNumber,
                              userColor: move.userColor,
                              fenSimpleBeforeComputerMove: move.fenSimpleBeforeComputerMove,
                              fenBeforeComputerMove: move.fenBeforeComputerMove,
                              computerMove: move.computerMove,
                              fenSimpleBeforeUserMove: move.fenSimpleBeforeUserMove,
                              fenBeforeUserMove: move.fenBeforeUserMove,
                              commentBeforeUserMove: move.commentBeforeUserMove,
                              commentAfterUserMove: move.commentAfterUserMove,
                              correctUserMove: move.correctUserMove,
                              fenSimpleAfterUserMove: move.fenSimpleAfterUserMove,
                              fenAfterUserMove: move.fenAfterUserMove,
                              commentOnIncorrectMove: move.commentOnIncorrectMove)
    }
    
    static func get(db: Connection, id: String) throws -> LessonMoveInfo? {
        guard let row = try db.pluck(LessonMoveTable.table.filter(LessonMoveTable.identifier == id)) else {
            return nil
        }
        return LessonMoveInfo(id: row[LessonMoveTable.identifier],
                              updateDate: row[LessonMoveTable.updateDate],
                              moveNumber: row[LessonMoveTable.moveNumber],
                              userColor: PieceColor(rawValue: row[LessonMoveTable.userColor])!,
                              fenSimpleBeforeComputerMove: row[LessonMoveTable.fenSimpleBeforeComputerMove],
                              fenBeforeComputerMove: row[LessonMoveTable.fenBeforeComputerMove],
                              computerMove: row[LessonMoveTable.computerMove],
                              fenSimpleBeforeUserMove: row[LessonMoveTable.fenSimpleBeforeUserMove],
                              fenBeforeUserMove: row[LessonMoveTable.fenBeforeUserMove],
                              commentBeforeUserMove: row[LessonMoveTable.commentBeforeUserMove],
                              commentAfterUserMove: row[LessonMoveTable.commentAfterUserMove],
                              correctUserMove: row[LessonMoveTable.correctUserMove],
                              fenSimpleAfterUserMove: row[LessonMoveTable.fenSimpleAfterUserMove],
                              fenAfterUserMove: row[LessonMoveTable.fenAfterUserMove],
                              commentOnIncorrectMove: row[LessonMoveTable.commentOnIncorrectMove])

    }
}
