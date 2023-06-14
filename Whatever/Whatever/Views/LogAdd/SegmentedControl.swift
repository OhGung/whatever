//
//  SegmentedControl.swift
//  Whatever
//
//  Created by sei on 2023/06/13.
//

import SwiftUI

//struct SegmentedControl<Item>: View {
struct SegmentedControl: View {
//    var items: [Item] =

    var items: [Bool] = [false, true, false, false, false]
    var body: some View {
        ZStack {
            rectangle
            circles
        }
    }
    
//    var
    
    var rectangle: some View {
        Color.mediumGray
            .frame(height: 20)
    }
    
    var circles: some View {
        HStack {
            ForEach(items, id:\.self) { item in
                circle(selected: item)
            }
        }
    }
    
    @ViewBuilder
    func circle(selected: Bool) -> some View {
        if selected {
            ZStack {
                Circle()
                    .frame(height: 50)
                    .foregroundColor(.mediumGray)
                Circle()
                    .foregroundColor(.vividPurple)
                    .frame(height: 40)
            }
        } else {
            ZStack {
                Circle()
                    .frame(height: 50)
                    .foregroundColor(.mediumGray)
            }
        }
    }
}

struct SegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControl()
    }
}
