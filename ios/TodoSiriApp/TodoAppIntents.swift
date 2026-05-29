import AppIntents

@available(iOS 16.0, *)
struct AddTodoIntent: AppIntent {
    static var title: LocalizedStringResource = "Add To-Do"
    static var description = IntentDescription("Adds a new task to your to-do list.")

    @Parameter(title: "Task")
    var taskTitle: String

    func perform() async throws -> some IntentResult & ProvidesDialog {
        await MainActor.run {
            TodoStore.shared.add(title: taskTitle)
        }
        return .result(dialog: "Added \(taskTitle) to your to-do list.")
    }
}

@available(iOS 16.0, *)
struct TodoShortcutsProvider: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        [
            AppShortcut(
                intent: AddTodoIntent(),
                phrases: [
                    "Add \(.$taskTitle) to my to-do list",
                    "Create a to-do: \(.$taskTitle)"
                ],
                shortTitle: "Add To-Do"
            )
        ]
    }
}
