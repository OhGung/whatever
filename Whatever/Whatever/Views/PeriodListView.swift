//
//  PeriodList.swift
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
                    PeriodDetail(cycleLog: item, context: viewContext)
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
                PeriodWrite()
            }
        }
    }
    
    func cycleRow(_ cycle: CycleLog) -> some View {
        HStack(spacing: 10) {
            Text("\(cycle.wrappedDate, formatter: itemFormatter)")
            Text(cycle.wrappedPadType)
            Text(cycle.wrappedFlowLevel)
        }
    }
    
    // MARK: - Delete Cycle Log
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}



private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()
