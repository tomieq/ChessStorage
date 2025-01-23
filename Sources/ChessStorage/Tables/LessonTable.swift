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
    static let sequence = SQLite.Expression<Int>("sequence")
    static let updateDate = SQLite.Expression<Double>("updateDate")
    static let lessonName = SQLite.Expression<String>("name")
    static let lessonSubname = SQLite.Expression<String>("subname")
    static let type = SQLite.Expression<String>("type")
}

extension LessonTable {
    static func createTable(db: Connection) throws {
        try db.run(LessonTable.table.create(ifNotExists: true) { t in
            t.column(LessonTable.identifier)
            t.column(LessonTable.sequence)
            t.column(LessonTable.updateDate)
            t.column(LessonTable.lessonName)
            t.column(LessonTable.lessonSubname)
            t.column(LessonTable.type)
        })
        try db.run(LessonTable.table.createIndex(LessonTable.identifier, ifNotExists: true))
        try db.run(LessonTable.table.createIndex(LessonTable.sequence, ifNotExists: true))
        try db.run(LessonTable.table.createIndex(LessonTable.updateDate, ifNotExists: true))
    }
    
    static func count(db: Connection) throws -> Int {
        try db.scalar(LessonTable.table.count)
    }
    
    @discardableResult
    static func store(db: Connection, lesson: LessonInfo) throws -> LessonInfo {
        var lessonIdentifier = ""
        if let identifier = lesson.id,
           try db.scalar(LessonTable.table.filter(LessonTable.identifier == identifier).count) > 0 {
            lessonIdentifier = identifier
            try db.run(LessonTable.table.filter(LessonTable.identifier == identifier).update(
                LessonTable.sequence <- lesson.sequence,
                LessonTable.updateDate <- lesson.updateDate,
                LessonTable.lessonName <- lesson.name,
                LessonTable.lessonSubname <- lesson.subname,
                LessonTable.type <- lesson.type.rawValue
            ))
        } else {
            lessonIdentifier = lesson.id ?? UUID().uuidString
            try db.run(LessonTable.table.insert(
                LessonTable.identifier <- lessonIdentifier,
                LessonTable.sequence <- lesson.sequence,
                LessonTable.updateDate <- lesson.updateDate,
                LessonTable.lessonName <- lesson.name,
                LessonTable.lessonSubname <- lesson.subname,
                LessonTable.type <- lesson.type.rawValue
            ))
        }
        return LessonInfo(id: lessonIdentifier,
                          sequence: lesson.sequence,
                          updateDate: lesson.updateDate,
                          name: lesson.name,
                          subname: lesson.subname,
                          type: lesson.type)
    }
    
    static func get(db: Connection, id: String) throws -> LessonInfo? {
        guard let row = try db.pluck(LessonTable.table.filter(LessonTable.identifier == id)) else {
            return nil
        }
        return LessonInfo(id: row[LessonTable.identifier],
                          sequence: row[LessonTable.sequence],
                          updateDate: row[LessonTable.updateDate],
                          name: row[LessonTable.lessonName],
                          subname: row[LessonTable.lessonSubname],
                          type: LessonType(rawValue: row[LessonTable.type])!)
    }
}
