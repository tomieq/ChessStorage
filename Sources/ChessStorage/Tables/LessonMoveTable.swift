//
//  LessonMoveTable.swift
//  ChessStorage
//
//  Created by Tomasz KUCHARSKI on 23/01/2025.
//

import Foundation
@preconcurrency import SQLite

enum LessonMoveTable {
    static let name = "moves"
    static let table = Table(Self.name)
    static let identifier = SQLite.Expression<String>("identifier")
    static let lessonIdentifier = SQLite.Expression<String>("lessonIdentifier")
    static let moveNumber = SQLite.Expression<Int>("moveNumber")
    static let updateDate = SQLite.Expression<Double>("updateDate")
    static let userColor = SQLite.Expression<String>("userColor")
    
    static let fenBeforeComputerMove = SQLite.Expression<String?>("fenBeforeComputerMove")
    static let computerMove = SQLite.Expression<String?>("computerMove")
    
    static let fenBeforeUserMove = SQLite.Expression<String>("fenBeforeUserMove")
    static let commentBeforeUserMove = SQLite.Expression<String?>("commentBeforeUserMove")
    static let commentAfterUserMove = SQLite.Expression<String?>("commentAfterUserMove")
    static let correctUserMove = SQLite.Expression<String>("correctUserMove")
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
            t.column(LessonMoveTable.fenBeforeComputerMove)
            t.column(LessonMoveTable.computerMove)
            t.column(LessonMoveTable.fenBeforeUserMove)
            t.column(LessonMoveTable.commentBeforeUserMove)
            t.column(LessonMoveTable.commentAfterUserMove)
            t.column(LessonMoveTable.correctUserMove)
            t.column(LessonMoveTable.commentOnIncorrectMove)
        })
        try db.run(LessonMoveTable.table.createIndex(LessonMoveTable.identifier, ifNotExists: true))
        try db.run(LessonMoveTable.table.createIndex(LessonMoveTable.lessonIdentifier, ifNotExists: true))
        try db.run(LessonMoveTable.table.createIndex(LessonMoveTable.updateDate, ifNotExists: true))
        try db.run(LessonMoveTable.table.createIndex(LessonMoveTable.moveNumber, ifNotExists: true))
    }
    
    static func count(db: Connection) throws -> Int {
        try db.scalar(LessonMoveTable.table.count)
    }
    
    static func store(db: Connection, move: LessonMove) throws {
        if try db.scalar(LessonMoveTable.table.filter(LessonMoveTable.identifier == move.id).count) > 0 {
            try db.run(LessonMoveTable.table.filter(LessonMoveTable.identifier == identifier).update(
                LessonMoveTable.lessonIdentifier <- move.lessonID,
                LessonMoveTable.updateDate <- move.updateDate,
                LessonMoveTable.moveNumber <- move.moveNumber,
                LessonMoveTable.userColor <- move.userColor.rawValue,
                LessonMoveTable.fenBeforeComputerMove <- move.fenBeforeComputerMove,
                LessonMoveTable.computerMove <- move.computerMove,
                LessonMoveTable.fenBeforeUserMove <- move.fenBeforeUserMove,
                LessonMoveTable.commentBeforeUserMove <- move.commentBeforeUserMove,
                LessonMoveTable.commentAfterUserMove <- move.commentAfterUserMove,
                LessonMoveTable.correctUserMove <- move.correctUserMove,
                LessonMoveTable.commentOnIncorrectMove <- move.commentOnIncorrectMove
            ))
        } else {
            try db.run(LessonMoveTable.table.insert(
                LessonMoveTable.identifier <- move.id,
                LessonMoveTable.lessonIdentifier <- move.lessonID,
                LessonMoveTable.updateDate <- move.updateDate,
                LessonMoveTable.moveNumber <- move.moveNumber,
                LessonMoveTable.userColor <- move.userColor.rawValue,
                LessonMoveTable.fenBeforeComputerMove <- move.fenBeforeComputerMove,
                LessonMoveTable.computerMove <- move.computerMove,
                LessonMoveTable.fenBeforeUserMove <- move.fenBeforeUserMove,
                LessonMoveTable.commentBeforeUserMove <- move.commentBeforeUserMove,
                LessonMoveTable.commentAfterUserMove <- move.commentAfterUserMove,
                LessonMoveTable.correctUserMove <- move.correctUserMove,
                LessonMoveTable.commentOnIncorrectMove <- move.commentOnIncorrectMove
            ))
        }
    }
    
    static func get(db: Connection, id: String) throws -> LessonMove? {
        guard let row = try db.pluck(LessonMoveTable.table.filter(LessonMoveTable.identifier == id)) else {
            return nil
        }
        return lessonMoveInfo(from: row)
    }
    
    static func get(db: Connection, lessonID: String) throws -> [LessonMove] {
        var result: [LessonMove] = []
        for row in try db.prepare(LessonMoveTable.table
            .filter(LessonMoveTable.lessonIdentifier == lessonID)
            .order(LessonMoveTable.moveNumber.asc)) {
            result.append(lessonMoveInfo(from: row))
        }
        return result
    }

    private static func lessonMoveInfo(from row: Row) -> LessonMove {
        LessonMove(id: row[LessonMoveTable.identifier],
                       lessonID: row[LessonMoveTable.lessonIdentifier],
                       updateDate: row[LessonMoveTable.updateDate],
                       moveNumber: row[LessonMoveTable.moveNumber],
                       userColor: PieceColor(rawValue: row[LessonMoveTable.userColor])!,
                       fenBeforeComputerMove: row[LessonMoveTable.fenBeforeComputerMove],
                       computerMove: row[LessonMoveTable.computerMove],
                       fenBeforeUserMove: row[LessonMoveTable.fenBeforeUserMove],
                       commentBeforeUserMove: row[LessonMoveTable.commentBeforeUserMove],
                       commentAfterUserMove: row[LessonMoveTable.commentAfterUserMove],
                       correctUserMove: row[LessonMoveTable.correctUserMove],
                       commentOnIncorrectMove: row[LessonMoveTable.commentOnIncorrectMove])
    }
}
