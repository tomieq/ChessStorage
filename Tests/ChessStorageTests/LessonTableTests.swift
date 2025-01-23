//
//  LessonTableTests.swift
//  ChessStorage
//
//  Created by Tomasz on 23/01/2025.
//

import Testing
import SQLite
@testable import ChessStorage

struct LessonTableTests {
    var sampleLesson: LessonInfo {
        LessonInfo(id: nil,
                   sequence: 1,
                   updateDate: 5,
                   name: "first",
                   subname: "test",
                   type: .opening)
    }

    @Test func emptyDatabase() async throws {
        let db = try Connection(.inMemory)
        try LessonTable.createTable(db: db)
        #expect(try LessonTable.count(db: db) == 0)
    }
    
    @Test func storeLesson() async throws {
        let db = try Connection(.inMemory)
        try LessonTable.createTable(db: db)
        let stored = try LessonTable.store(db: db, lesson: sampleLesson)
        #expect(try LessonTable.count(db: db) == 1)
        #expect(stored.name == sampleLesson.name)
        #expect(stored.subname == sampleLesson.subname)
        #expect(stored.type == sampleLesson.type)
        #expect(stored.sequence == sampleLesson.sequence)
        #expect(stored.updateDate == sampleLesson.updateDate)
        try LessonTable.store(db: db, lesson: sampleLesson)
        #expect(try LessonTable.count(db: db) == 2)
    }
    
    @Test func getLesson() async throws {
        let db = try Connection(.inMemory)
        try LessonTable.createTable(db: db)
        let stored = try LessonTable.store(db: db, lesson: sampleLesson)
        let restored = try LessonTable.get(db: db, id: stored.id!)
        #expect(restored?.name == sampleLesson.name)
        #expect(restored?.subname == sampleLesson.subname)
        #expect(restored?.type == sampleLesson.type)
        #expect(restored?.sequence == sampleLesson.sequence)
        #expect(restored?.updateDate == sampleLesson.updateDate)
        #expect(restored?.id == stored.id)
    }

    @Test func updateLesson() async throws {
        let db = try Connection(.inMemory)
        try LessonTable.createTable(db: db)
        let stored = try LessonTable.store(db: db, lesson: sampleLesson)
        #expect(try LessonTable.count(db: db) == 1)
        try LessonTable.store(db: db, lesson: stored)
        #expect(try LessonTable.count(db: db) == 1)
    }
}
