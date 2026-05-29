import SwiftUI

struct ContentView: View {
    @StateObject private var store = TodoStore.shared
    @State private var newTodoTitle = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                HStack {
                    TextField("Add a to-do", text: $newTodoTitle)
                        .textFieldStyle(.roundedBorder)
                    Button("Add") {
                        store.add(title: newTodoTitle)
                        newTodoTitle = ""
                    }
                }

                List(store.todos) { todo in
                    Text(todo.title)
                }
            }
            .padding()
            .navigationTitle("To-Dos")
        }
    }
}
