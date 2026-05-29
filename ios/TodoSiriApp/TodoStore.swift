import Foundation
import Combine

@MainActor
final class TodoStore: ObservableObject {
    static let shared = TodoStore()

    @Published private(set) var todos: [TodoItem] = []

    private let defaultsKey = "todo_items"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private init() {
        load()
    }

    func add(title: String) {
        let cleanedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanedTitle.isEmpty else { return }

        todos.insert(TodoItem(title: cleanedTitle), at: 0)
        save()
    }

    private func save() {
        guard let data = try? encoder.encode(todos) else { return }
        UserDefaults.standard.set(data, forKey: defaultsKey)
    }

    private func load() {
        guard
            let data = UserDefaults.standard.data(forKey: defaultsKey),
            let loaded = try? decoder.decode([TodoItem].self, from: data)
        else {
            todos = []
            return
        }

        todos = loaded
    }
}
