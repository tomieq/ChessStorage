//
//  LessonGroup.swift
//  ChessStorage
//
//  Created by Tomasz on 23/01/2025.
//

public struct LessonGroup: Codable {
    public let id: String?
    public let sequence: Int
    public let updateDate: Double
    public let name: String
}
