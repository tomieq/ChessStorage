//
//  LessonTableTests.swift
//  ChessStorage
//
//  Created by Tomasz on 23/01/2025.
//

import Foundation
import Testing
import SQLite
@testable import ChessStorage

struct LessonTableTests {
    var sampleLesson: Lesson {
        Lesson(id: UUID().uuidString,
               groupID: UUID().uuidString,
               sequence: 1,
               updateDate: 5,
               name: UUID().uuidString,
               subname: UUID().uuidString,
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
        try LessonTable.store(db: db, lesson: sampleLesson)
        #expect(try LessonTable.count(db: db) == 2)
    }
    
    @Test func getLesson() async throws {
        let db = try Connection(.inMemory)
        try LessonTable.createTable(db: db)
        let lesson = sampleLesson
        try LessonTable.store(db: db, lesson: lesson)
        let restored = try LessonTable.get(db: db, id: lesson.id)
        #expect(restored?.name == lesson.name)
        #expect(restored?.subname == lesson.subname)
        #expect(restored?.type == lesson.type)
        #expect(restored?.sequence == lesson.sequence)
        #expect(restored?.updateDate == lesson.updateDate)
        #expect(restored?.id == lesson.id)
    }

    @Test func updateLesson() async throws {
        let db = try Connection(.inMemory)
        try LessonTable.createTable(db: db)
        let lesson = sampleLesson
        try LessonTable.store(db: db, lesson: lesson)
        #expect(try LessonTable.count(db: db) == 1)
        try LessonTable.store(db: db, lesson: lesson)
        #expect(try LessonTable.count(db: db) == 1)
    }
}
