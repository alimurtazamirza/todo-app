import AppIntents

@available(iOS 16.0, *)
struct AddTodoIntent: AppIntent {
    static var title: LocalizedStringResource = "Add To-Do"
    static var description = IntentDescription("Adds a new task to your to-do list.")

    @Parameter(title: "Task")
    var title: String

    func perform() async throws -> some IntentResult & ProvidesDialog {
        await MainActor.run {
            TodoStore.shared.add(title: title)
        }
        return .result(dialog: "Added \(title) to your to-do list.")
    }
}

@available(iOS 16.0, *)
struct TodoShortcutsProvider: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        [
            AppShortcut(
                intent: AddTodoIntent(),
                phrases: [
                    "Add \(.$title) to my to-do list",
                    "Create a to-do: \(.$title)"
                ],
                shortTitle: "Add To-Do"
            )
        ]
    }
}
