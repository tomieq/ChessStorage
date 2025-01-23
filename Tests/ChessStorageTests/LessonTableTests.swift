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
        try LessonTable.store(db: db, lesson: sampleLesson)
        #expect(try LessonTable.count(db: db) == 1)
        try LessonTable.store(db: db, lesson: sampleLesson)
        #expect(try LessonTable.count(db: db) == 2)
    }
}
