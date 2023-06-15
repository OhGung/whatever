//
//  MainView.swift
//  Whatever
//
//  Created by sei on 2023/06/11.
//

import SwiftUI
import CoreData

struct MainView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CycleLog.timestamp, ascending: false)],
        animation: .default)
    private var cycleLogs: FetchedResults<CycleLog>
    
    var body: some View {
        PeriodListView(items:cycleLogs)
        
        
        
        
        
        
        
        
        
    }
}












struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

