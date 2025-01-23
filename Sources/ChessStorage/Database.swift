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
        try? LessonTable.createTable(db: db)
    }
}
