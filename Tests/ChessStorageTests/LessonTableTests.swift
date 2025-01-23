//
//  LessonTableTests.swift
//  ChessStorage
//
//  Created by Tomasz on 23/01/2025.
//

import Testing
import SQLite
@testable import ChessStorage

@Test func emptyDatabase() async throws {
    let db = try Connection(.inMemory)
    try LessonTable.createTable(db: db)
    #expect(try LessonTable.count(db: db) == 0)
}
