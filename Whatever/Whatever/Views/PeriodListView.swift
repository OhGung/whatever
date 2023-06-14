//
//  PeriodListView.swift
//  Whatever
//
//  Created by sei on 2023/06/07.
//

import SwiftUI

struct PeriodListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isAddingNewCycleLog = false
    var items: FetchedResults<CycleLog>
    
    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink {
                    PeriodDetailView(cycleLog: item, context: viewContext)
                } label: {
                    cycleRow(item)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button {
                    isAddingNewCycleLog = true
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddingNewCycleLog) {
            NavigationView {
                LogAddView<LogAddViewModel>(viewModel: .preview)
            }
        }
    }
    
    private func cycleRow(_ cycle: CycleLog) -> some View {
        HStack(spacing: 10) {
            Text("\(cycle.wrappedDate, formatter: itemFormatter)")
            Text(cycle.wrappedPadType)
            Text(cycle.wrappedFlowLevel)
        }
    }
    
    // MARK: - Usage of Delete Cycle Log
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(PersistenceController.shared.deleteLog)
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()
