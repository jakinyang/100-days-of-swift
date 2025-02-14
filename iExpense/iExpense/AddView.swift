import SwiftUI

struct AddView: View {
    @State private var name: String = ""
    @State private var type: ExpenseType = .personal
    @State private var amount: String = ""
    
    @Environment(\.dismiss) var dismiss
    @FocusState private var isAmountFocused: Bool
    
    var expenses: Expenses
    
    func validateExpenseForm(name: String, type: ExpenseType, amount: String) {
        print("Validated!")
        print(name)
        print(type)
        print(amount)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Name", text: $name)
                    
                    Picker("Type", selection: $type) {
                        ForEach(ExpenseType.allCases) { expenseType in
                            Text(expenseType.rawValue).tag(expenseType)
                        }
                    }
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                        .focused($isAmountFocused)
                        .onAppear {
                            if amount.isEmpty { amount = "0.00" }
                        }
                        .onChange(of: isAmountFocused) {
                            if $0 {
                                amount = "" // Clear input on focus
                            } else if amount.isEmpty {
                                amount = "0.00" // Reset if left empty
                            }
                        }

                }
                .navigationTitle("Add new expense")
            }
            .toolbar {
                Button("Save") {
                    validateExpenseForm(name: name, type: type, amount: amount)
                    let expense = ExpenseItem(name: name, type: type, amount: amount)
                    
                    expenses.items.append(expense)
                    
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
