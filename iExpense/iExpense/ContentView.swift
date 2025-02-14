//
//  ContentView.swift
//  iExpense
//
//  Created by Jae Chun Yang on 2025-01-30.
//

import SwiftUI
import Observation

enum ExpenseType: String, Codable, CaseIterable, Identifiable {
    case personal = "Personal"
    case business = "Business"
    
    var id: String { self.rawValue } // Required for Identifiable
}


struct ExpenseItem: Identifiable, Codable {
    var id: UUID = UUID()
    let name: String
    let type: ExpenseType
    let amount: String
}

@Observable
class Expenses {
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "ExpenseItems") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "ExpenseItems")
            }
        }
    }
}

func getAmountForegroundStyle(amount: Double) -> Color {
    return if amount > 100 {
        Color.red
    } else if amount > 50 {
        Color.orange
    } else if amount > 10 {
        Color.blue
    } else {
        Color.black
    }
}

struct ContentView: View {
    @State private var expenses: Expenses = Expenses()
    @State private var showingAddExpenseSheet: Bool = false
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type.rawValue)
                        }
                        
                        Spacer()
                        Text(Double(item.amount) ?? 0, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .foregroundStyle(getAmountForegroundStyle(amount: (Double(item.amount) ?? 0)))
                    }
                    
                }
                .onDelete(perform: removeItems)
            }
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpenseSheet.toggle()
                }
            }
            .navigationTitle("iExpense")
        }
        .sheet(isPresented: $showingAddExpenseSheet) {
            AddView(expenses: expenses)
        }
    }
}

#Preview {
    ContentView()
}
