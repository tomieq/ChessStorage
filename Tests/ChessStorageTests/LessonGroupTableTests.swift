//
//  LessonGroupTableTests.swift
//  ChessStorage
//
//  Created by Tomasz on 23/01/2025.
//

import Foundation
import Testing
import SQLite
@testable import ChessStorage

struct LessonGroupTableTests {
    var sampleGroup: LessonGroup {
        LessonGroup(id: nil,
                    sequence: 1,
                    updateDate: 23553,
                    name: UUID().uuidString)
    }
    
    @Test func emptyDatabase() async throws {
        let db = try Connection(.inMemory)
        try LessonGroupTable.createTable(db: db)
        #expect(try LessonGroupTable.count(db: db) == 0)
    }
    
    @Test func storeGroup() async throws {
        let db = try Connection(.inMemory)
        try LessonGroupTable.createTable(db: db)
        let group = sampleGroup
        let stored = try LessonGroupTable.store(db: db, group: group)
        #expect(try LessonGroupTable.count(db: db) == 1)
        #expect(stored.name == group.name)
        #expect(stored.sequence == group.sequence)
        #expect(stored.updateDate == group.updateDate)
        try LessonGroupTable.store(db: db, group: group)
        #expect(try LessonGroupTable.count(db: db) == 2)
    }
    
    @Test func getGroup() async throws {
        let db = try Connection(.inMemory)
        try LessonGroupTable.createTable(db: db)
        let group = sampleGroup
        let stored = try LessonGroupTable.store(db: db, group: group)
        let restored = try LessonGroupTable.get(db: db, id: stored.id!)
        #expect(restored?.name == group.name)
        #expect(restored?.sequence == group.sequence)
        #expect(restored?.updateDate == group.updateDate)
        #expect(restored?.id == stored.id)
    }
    
    @Test func updateGroup() async throws {
        let db = try Connection(.inMemory)
        try LessonGroupTable.createTable(db: db)
        let group = sampleGroup
        let stored = try LessonGroupTable.store(db: db, group: group)
        #expect(try LessonGroupTable.count(db: db) == 1)
        try LessonGroupTable.store(db: db, group: stored)
        #expect(try LessonGroupTable.count(db: db) == 1)
    }
}
