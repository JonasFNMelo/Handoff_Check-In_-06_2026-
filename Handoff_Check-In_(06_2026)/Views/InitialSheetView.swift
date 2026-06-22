//
//  InitialSheetView.swift
//  Handoff_Check-In_(06_2026)
//
//  Created by Jonas Fernando Nascimento Melo on 22/06/26.
//

import SwiftUI

struct InitialSheetView: View {
    @State private var fractionShowing = 0.15
    @State private var isHidden = true
    @State private var searchText = ""
    
    var allLines = ["1"]
    var filteredLines: [String] {
        if searchText.isEmpty {
            allLines
        } else {
            allLines.filter { $0.localizedStandardContains(searchText) }
        }
    }
    var body: some View {
        VStack{
            
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .animation(.spring(), value: isHidden)
        .presentationDetents([.fraction(fractionShowing), .medium])
        .interactiveDismissDisabled(true)
    }
    
    var SwipeUpGesture: some Gesture {
        DragGesture(minimumDistance: 20, coordinateSpace: .local)
            .onEnded { value in
                if value.translation.height < -20 {
                    fractionShowing = 0.4
                    isHidden = false
                } else if value.translation.height > 20 {
                    fractionShowing = 0.15
                    isHidden = true
                }
            }
    }
}

#Preview {
    InitialSheetView()
}
