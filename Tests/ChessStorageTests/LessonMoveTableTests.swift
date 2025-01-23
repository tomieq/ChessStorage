//
//  LessonMoveTableTests.swift
//  ChessStorage
//
//  Created by Tomasz on 23/01/2025.
//

import Foundation
import Testing
import SQLite
@testable import ChessStorage

struct LessonMoveTableTests {
    var sampleMove: LessonMove {
        LessonMove(id: UUID().uuidString,
                       lessonID: UUID().uuidString,
                       updateDate: 876,
                       moveNumber: 3,
                       userColor: .white,
                       fenSimpleBeforeComputerMove: UUID().uuidString,
                       fenBeforeComputerMove: UUID().uuidString,
                       computerMove: UUID().uuidString,
                       fenSimpleBeforeUserMove: UUID().uuidString,
                       fenBeforeUserMove: UUID().uuidString,
                       commentBeforeUserMove: UUID().uuidString,
                       commentAfterUserMove: UUID().uuidString,
                       correctUserMove: UUID().uuidString,
                       fenSimpleAfterUserMove: UUID().uuidString,
                       fenAfterUserMove: UUID().uuidString,
                       commentOnIncorrectMove: UUID().uuidString)
    }

    @Test func emptyDatabase() async throws {
        let db = try Connection(.inMemory)
        try LessonMoveTable.createTable(db: db)
        #expect(try LessonMoveTable.count(db: db) == 0)
    }
    
    @Test func storeMove() async throws {
        let db = try Connection(.inMemory)
        try LessonMoveTable.createTable(db: db)
        try LessonMoveTable.store(db: db, move: sampleMove)
        try LessonMoveTable.store(db: db, move: sampleMove)
        #expect(try LessonMoveTable.count(db: db) == 2)
    }
    
    @Test func getMove() async throws {
        let db = try Connection(.inMemory)
        try LessonMoveTable.createTable(db: db)
        let move = sampleMove
        try LessonMoveTable.store(db: db, move: move)
        let restored = try LessonMoveTable.get(db: db, id: move.id)
        #expect(restored?.updateDate == move.updateDate)
        #expect(restored?.moveNumber == move.moveNumber)
        #expect(restored?.userColor == move.userColor)
        #expect(restored?.fenSimpleBeforeComputerMove == move.fenSimpleBeforeComputerMove)
        #expect(restored?.fenBeforeComputerMove == move.fenBeforeComputerMove)
        #expect(restored?.computerMove == move.computerMove)
        #expect(restored?.fenSimpleBeforeUserMove == move.fenSimpleBeforeUserMove)
        #expect(restored?.fenBeforeUserMove == move.fenBeforeUserMove)
        #expect(restored?.commentBeforeUserMove == move.commentBeforeUserMove)
        #expect(restored?.commentAfterUserMove == move.commentAfterUserMove)
        #expect(restored?.correctUserMove == move.correctUserMove)
        #expect(restored?.fenSimpleAfterUserMove == move.fenSimpleAfterUserMove)
        #expect(restored?.fenAfterUserMove == move.fenAfterUserMove)
        #expect(restored?.commentOnIncorrectMove == move.commentOnIncorrectMove)
        #expect(restored?.id == move.id)
    }

    @Test func updateMove() async throws {
        let db = try Connection(.inMemory)
        try LessonMoveTable.createTable(db: db)
        let move = sampleMove
        try LessonMoveTable.store(db: db, move: move)
        #expect(try LessonMoveTable.count(db: db) == 1)
        try LessonMoveTable.store(db: db, move: move)
        #expect(try LessonMoveTable.count(db: db) == 1)
        let restored = try LessonMoveTable.get(db: db, id: move.id)
        #expect(restored?.updateDate == move.updateDate)
        #expect(restored?.moveNumber == move.moveNumber)
        #expect(restored?.userColor == move.userColor)
        #expect(restored?.fenSimpleBeforeComputerMove == move.fenSimpleBeforeComputerMove)
        #expect(restored?.fenBeforeComputerMove == move.fenBeforeComputerMove)
        #expect(restored?.computerMove == move.computerMove)
        #expect(restored?.fenSimpleBeforeUserMove == move.fenSimpleBeforeUserMove)
        #expect(restored?.fenBeforeUserMove == move.fenBeforeUserMove)
        #expect(restored?.commentBeforeUserMove == move.commentBeforeUserMove)
        #expect(restored?.commentAfterUserMove == move.commentAfterUserMove)
        #expect(restored?.correctUserMove == move.correctUserMove)
        #expect(restored?.fenSimpleAfterUserMove == move.fenSimpleAfterUserMove)
        #expect(restored?.fenAfterUserMove == move.fenAfterUserMove)
        #expect(restored?.commentOnIncorrectMove == move.commentOnIncorrectMove)
        #expect(restored?.id == move.id)
    }
}
