//
//  Database.swift
//  ChessStorage
//
//  Created by Tomasz on 23/01/2025.
//

import SQLite

public class Database {
    let db: Connection
    
    public init(absolutePath: String) throws {
        self.db = try Connection(absolutePath)
        try? LessonGroupTable.createTable(db: db)
        try? LessonTable.createTable(db: db)
        try? LessonMoveTable.createTable(db: db)
    }
    
    public var allGroups: [LessonGroup] {
        get throws {
            try LessonGroupTable.get(db: db)
        }
    }
    
    public func create(group: LessonGroup) throws {
        try LessonGroupTable.store(db: db, group: group)
    }
    
    public func create(lesson: Lesson) throws {
        try LessonTable.store(db: db, lesson: lesson)
    }
    
    public func lessons(groupID: String) throws -> [Lesson] {
        try LessonTable.get(db: db, groupID: groupID)
    }
    
    public func create(move: LessonMove) throws {
        try LessonMoveTable.store(db: db, move: move)
    }
    
    public func moves(lessonID: String) throws -> [LessonMove] {
        try LessonMoveTable.get(db: db, lessonID: lessonID)
    }
}
