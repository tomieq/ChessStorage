//
//  LessonResultTable.swift
//  ChessStorage
//
//  Created by Tomasz on 31/01/2025.
//

import Foundation
import Testing
import SQLite
@testable import ChessStorage

struct LessonResultTableTests {
    
    @Test func emptyDatabase() async throws {
        let db = try Connection(.inMemory)
        try LessonResultTable.createTable(db: db)
        #expect(try LessonResultTable.count(db: db) == 0)
    }
    
    @Test func storeResult() async throws {
        let db = try Connection(.inMemory)
        try LessonResultTable.createTable(db: db)
        try LessonResultTable.store(db: db, lessonID: "first", result: "success")
        #expect(try LessonResultTable.count(db: db) == 1)
        try LessonResultTable.store(db: db, lessonID: "second", result: "failed")
        #expect(try LessonResultTable.count(db: db) == 2)
    }
    
    @Test func getResults() async throws {
        let db = try Connection(.inMemory)
        try LessonResultTable.createTable(db: db)
        try LessonResultTable.store(db: db, lessonID: "first", result: "success")
        let restored = try LessonResultTable.getAll(db: db).first
        #expect(restored?.lessonID == "first")
        #expect(restored?.result == "success")
    }
    
    @Test func removeAll() async throws {
        let db = try Connection(.inMemory)
        try LessonResultTable.createTable(db: db)
        try LessonResultTable.store(db: db, lessonID: "first", result: "success")
        try LessonResultTable.store(db: db, lessonID: "second", result: "failed")
        #expect(try LessonResultTable.count(db: db) == 2)
        try LessonResultTable.removeAll(db: db)
        #expect(try LessonResultTable.count(db: db) == 0)
    }
}
