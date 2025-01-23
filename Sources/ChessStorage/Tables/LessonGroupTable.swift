//
//  LessonGroupTable.swift
//  ChessStorage
//
//  Created by Tomasz on 23/01/2025.
//
import Foundation
@preconcurrency import SQLite

enum LessonGroupTable {
    static let name = "groups"
    static let table = Table(Self.name)
    static let identifier = SQLite.Expression<String>("identifier")
    static let groupName = SQLite.Expression<String>("name")
    static let sequence = SQLite.Expression<Int>("sequence")
    static let updateDate = SQLite.Expression<Double>("updateDate")
}

extension LessonGroupTable {
    static func createTable(db: Connection) throws {
        try db.run(LessonGroupTable.table.create(ifNotExists: true) { t in
            t.column(LessonGroupTable.identifier)
            t.column(LessonGroupTable.groupName)
            t.column(LessonGroupTable.sequence)
            t.column(LessonGroupTable.updateDate)
        })
        try db.run(LessonGroupTable.table.createIndex(LessonGroupTable.identifier, ifNotExists: true))
        try db.run(LessonGroupTable.table.createIndex(LessonGroupTable.sequence, ifNotExists: true))
        try db.run(LessonGroupTable.table.createIndex(LessonGroupTable.updateDate, ifNotExists: true))
    }
    
    static func count(db: Connection) throws -> Int {
        try db.scalar(LessonGroupTable.table.count)
    }
    
    static func store(db: Connection, group: LessonGroup) throws {
        if try db.scalar(LessonGroupTable.table.filter(LessonGroupTable.identifier == group.id).count) > 0 {
            try db.run(LessonGroupTable.table.filter(LessonGroupTable.identifier == group.id).update(
                LessonGroupTable.sequence <- group.sequence,
                LessonGroupTable.updateDate <- group.updateDate,
                LessonGroupTable.groupName <- group.name
            ))
        } else {
            try db.run(LessonGroupTable.table.insert(
                LessonGroupTable.identifier <- group.id,
                LessonGroupTable.sequence <- group.sequence,
                LessonGroupTable.updateDate <- group.updateDate,
                LessonGroupTable.groupName <- group.name
            ))
        }
    }
    
    static func get(db: Connection, id: String) throws -> LessonGroup? {
        guard let row = try db.pluck(LessonGroupTable.table.filter(LessonGroupTable.identifier == id)) else {
            return nil
        }
        return group(from: row)
    }
    
    static func get(db: Connection) throws -> [LessonGroup] {
        var result: [LessonGroup] = []
        for row in try db.prepare(LessonGroupTable.table
            .order(LessonGroupTable.sequence)) {
            result.append(group(from: row))
        }
        return result
    }
    
    private static func group(from row: Row) -> LessonGroup {
        LessonGroup(id: row[LessonGroupTable.identifier],
                    sequence: row[LessonGroupTable.sequence],
                    updateDate: row[LessonGroupTable.updateDate],
                    name: row[LessonGroupTable.groupName])
    }
}
