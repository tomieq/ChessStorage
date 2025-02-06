//
//  LessonTable.swift
//  ChessStorage
//
//  Created by Tomasz on 23/01/2025.
//
import Foundation
@preconcurrency import SQLite

enum LessonTable {
    static let name = "lessons"
    static let table = Table(Self.name)
    static let identifier = SQLite.Expression<String>("identifier")
    static let groupIdentifier = SQLite.Expression<String>("groupIdentifier")
    static let sequence = SQLite.Expression<Int>("sequence")
    static let updateDate = SQLite.Expression<Double>("updateDate")
    static let lessonName = SQLite.Expression<String>("name")
    static let lessonSubname = SQLite.Expression<String>("subname")
    static let type = SQLite.Expression<String>("type")
    static let rating = SQLite.Expression<Int?>("rating")
}

extension LessonTable {
    static func createTable(db: Connection) throws {
        try db.run(LessonTable.table.create(ifNotExists: true) { t in
            t.column(LessonTable.identifier)
            t.column(LessonTable.groupIdentifier)
            t.column(LessonTable.sequence)
            t.column(LessonTable.updateDate)
            t.column(LessonTable.lessonName)
            t.column(LessonTable.lessonSubname)
            t.column(LessonTable.type)
            t.column(LessonTable.rating)
        })
        try db.run(LessonTable.table.createIndex(LessonTable.identifier, ifNotExists: true))
        try db.run(LessonTable.table.createIndex(LessonTable.groupIdentifier, ifNotExists: true))
        try db.run(LessonTable.table.createIndex(LessonTable.sequence, ifNotExists: true))
        try db.run(LessonTable.table.createIndex(LessonTable.updateDate, ifNotExists: true))
        try db.run(LessonTable.table.createIndex(LessonTable.rating, ifNotExists: true))
    }
    
    static func count(db: Connection) throws -> Int {
        try db.scalar(LessonTable.table.count)
    }
    
    static func store(db: Connection, lesson: Lesson) throws {
        if try db.scalar(LessonTable.table.filter(LessonTable.identifier == lesson.id).count) > 0 {
            try db.run(LessonTable.table.filter(LessonTable.identifier == lesson.id)
                .update(
                    LessonTable.groupIdentifier <- lesson.groupID,
                    LessonTable.sequence <- lesson.sequence,
                    LessonTable.updateDate <- lesson.updateDate,
                    LessonTable.lessonName <- lesson.name,
                    LessonTable.lessonSubname <- lesson.subname,
                    LessonTable.type <- lesson.type.rawValue,
                    LessonTable.rating <- lesson.rating
                ))
        } else {
            try db.run(LessonTable.table.insert(
                LessonTable.identifier <- lesson.id,
                LessonTable.groupIdentifier <- lesson.groupID,
                LessonTable.sequence <- lesson.sequence,
                LessonTable.updateDate <- lesson.updateDate,
                LessonTable.lessonName <- lesson.name,
                LessonTable.lessonSubname <- lesson.subname,
                LessonTable.type <- lesson.type.rawValue,
                LessonTable.rating <- lesson.rating
            ))
        }
    }
    
    static func get(db: Connection, id: String) throws -> Lesson? {
        guard let row = try db.pluck(LessonTable.table.filter(LessonTable.identifier == id)) else {
            return nil
        }
        return lesson(from: row)
    }
    
    static func get(db: Connection, groupID: String) throws -> [Lesson] {
        var result: [Lesson] = []
        for row in try db.prepare(LessonTable.table
            .filter(LessonTable.groupIdentifier == groupID)
            .order(LessonTable.sequence)) {
            result.append(lesson(from: row))
        }
        return result
    }
    
    private static func lesson(from row: Row) -> Lesson {
        Lesson(id: row[LessonTable.identifier],
               groupID: row[LessonTable.groupIdentifier],
               sequence: row[LessonTable.sequence],
               updateDate: row[LessonTable.updateDate],
               name: row[LessonTable.lessonName],
               subname: row[LessonTable.lessonSubname],
               type: LessonType(rawValue: row[LessonTable.type])!,
               rating: row[LessonTable.rating])
    }
}
