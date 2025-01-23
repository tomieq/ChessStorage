//
//  Lesson.swift
//  ChessStorage
//
//  Created by Tomasz on 23/01/2025.
//

public struct Lesson: Codable {
    public let id: String?
    public let groupID: String
    public let sequence: Int
    public let updateDate: Double
    public let name: String
    public let subname: String
    public let type: LessonType
    public let moves: [LessonMove]
}
