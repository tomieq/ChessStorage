//
//  LessonResultTable.swift
//  ChessStorage
//
//  Created by Tomasz on 31/01/2025.
//

import Foundation
@preconcurrency import SQLite

enum LessonResultTable {
    static let name = "lesson_results"
    static let table = Table(Self.name)
    static let identifier = SQLite.Expression<String>("identifier")
    static let lessonIdentifier = SQLite.Expression<String>("lessonIdentifier")
    static let result = SQLite.Expression<String>("result")
}

extension LessonResultTable {
    static func createTable(db: Connection) throws {
        try db.run(LessonResultTable.table.create(ifNotExists: true) { t in
            t.column(LessonResultTable.identifier)
            t.column(LessonResultTable.lessonIdentifier)
            t.column(LessonResultTable.result)
        })
        try db.run(LessonResultTable.table.createIndex(LessonResultTable.identifier, ifNotExists: true))
        try db.run(LessonResultTable.table.createIndex(LessonResultTable.lessonIdentifier, ifNotExists: true))
    }
    
    static func count(db: Connection) throws -> Int {
        try db.scalar(LessonResultTable.table.count)
    }
    
    static func store(db: Connection, lessonID: String, result: String) throws {
        if try db.scalar(LessonResultTable.table.filter(LessonResultTable.lessonIdentifier == lessonID).count) > 0 {
            try db.run(LessonResultTable.table.filter(LessonResultTable.lessonIdentifier == lessonID)
                .update(
                    LessonResultTable.result <- result
                ))
        } else {
            try db.run(LessonResultTable.table.insert(
                LessonResultTable.identifier <- UUID().uuidString,
                LessonResultTable.lessonIdentifier <- lessonID,
                LessonResultTable.result <- result
            ))
        }
    }
    
    static func getAll(db: Connection) throws -> [(lessonID: String, result: String)] {
        var result: [(lessonID: String, result: String)] = []
        for row in try db.prepare(LessonResultTable.table) {
            result.append((row[LessonResultTable.lessonIdentifier],
                           row[LessonResultTable.result]))
        }
        return result
    }
    
    static func removeAll(db: Connection) throws {
        try db.run(LessonResultTable.table.delete())
    }
}
