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
    var sampleMove: LessonMoveInfo {
        LessonMoveInfo(id: nil,
                       lessonID: "hakgefajehf",
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
        let move = sampleMove
        let stored = try LessonMoveTable.store(db: db, move: move)
        #expect(try LessonMoveTable.count(db: db) == 1)
        #expect(stored.updateDate == move.updateDate)
        #expect(stored.moveNumber == move.moveNumber)
        #expect(stored.userColor == move.userColor)
        #expect(stored.fenSimpleBeforeComputerMove == move.fenSimpleBeforeComputerMove)
        #expect(stored.fenBeforeComputerMove == move.fenBeforeComputerMove)
        #expect(stored.computerMove == move.computerMove)
        #expect(stored.fenSimpleBeforeUserMove == move.fenSimpleBeforeUserMove)
        #expect(stored.fenBeforeUserMove == move.fenBeforeUserMove)
        #expect(stored.commentBeforeUserMove == move.commentBeforeUserMove)
        #expect(stored.commentAfterUserMove == move.commentAfterUserMove)
        #expect(stored.correctUserMove == move.correctUserMove)
        #expect(stored.fenSimpleAfterUserMove == move.fenSimpleAfterUserMove)
        #expect(stored.fenAfterUserMove == move.fenAfterUserMove)
        #expect(stored.commentOnIncorrectMove == move.commentOnIncorrectMove)
        try LessonMoveTable.store(db: db, move: move)
        #expect(try LessonMoveTable.count(db: db) == 2)
    }
    
    @Test func getMove() async throws {
        let db = try Connection(.inMemory)
        try LessonMoveTable.createTable(db: db)
        let move = sampleMove
        let stored = try LessonMoveTable.store(db: db, move: move)
        let restored = try LessonMoveTable.get(db: db, id: stored.id!)
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
        #expect(restored?.id == stored.id)
    }

    @Test func updateMove() async throws {
        let db = try Connection(.inMemory)
        try LessonMoveTable.createTable(db: db)
        let move = sampleMove
        let stored = try LessonMoveTable.store(db: db, move: move)
        #expect(try LessonMoveTable.count(db: db) == 1)
        try LessonMoveTable.store(db: db, move: stored)
        #expect(try LessonMoveTable.count(db: db) == 1)
        let restored = try LessonMoveTable.get(db: db, id: stored.id!)
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
        #expect(restored?.id == stored.id)
    }
}
