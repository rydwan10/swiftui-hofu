//
//  Test.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 10/12/24.
//
import SwiftUI

// Model sederhana
struct Item: Identifiable {
    let id = UUID()
    var name: String
}

struct MainView: View {
    @State private var items = [Item(name: "Item 1"), Item(name: "Item 2")]
    @State private var selectedItem: Item?

    var body: some View {
        NavigationStack {
            List(items) { item in
                // Navigasi ke DetailView dengan data
                NavigationLink(destination: DetailView(item: item, onSave: { updatedItem in
                    // Update data setelah kembali
                    if let index = items.firstIndex(where: { $0.id == updatedItem.id }) {
                        items[index] = updatedItem
                    }
                })) {
                    Text(item.name)
                }
            }
            .navigationTitle("Items")
        }
    }
}

// DetailView menerima data dan mengirim balik data
struct DetailView: View {
    @State var item: Item
    var onSave: (Item) -> Void // Closure untuk passing data backward
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("Editing \(item.name)")
            TextField("Item Name", text: $item.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Save") {
                onSave(item) // Passing data back
                dismiss()
            
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Detail View")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
