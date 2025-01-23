//
//  LessonInfo.swift
//  ChessStorage
//
//  Created by Tomasz on 23/01/2025.
//

public struct LessonInfo: Codable {
    public let id: String?
    public let groupID: String
    public let sequence: Int
    public let updateDate: Double
    public let name: String
    public let subname: String
    public let type: LessonType
    
    public init(id: String? = nil, groupID: String, sequence: Int,
                updateDate: Double, name: String, subname: String, type: LessonType) {
        self.id = id
        self.groupID = groupID
        self.sequence = sequence
        self.updateDate = updateDate
        self.name = name
        self.subname = subname
        self.type = type
    }
}
