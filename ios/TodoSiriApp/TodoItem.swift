import Foundation

struct TodoItem: Identifiable, Codable, Equatable {
    let id: UUID
    let title: String
    let createdAt: Date

    init(id: UUID = UUID(), title: String, createdAt: Date = .now) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
    }
}
