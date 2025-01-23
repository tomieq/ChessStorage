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
    
    public init(id: String? = nil, sequence: Int, updateDate: Double, name: String) {
        self.id = id
        self.sequence = sequence
        self.updateDate = updateDate
        self.name = name
    }
}
