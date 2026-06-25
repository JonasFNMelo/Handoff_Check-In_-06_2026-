//
//  ContentView.swift
//  Handoff_Check-In_(06_2026)
//
//  Created by Jonas Fernando Nascimento Melo on 22/06/26.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var viewModel = ContentViewModel()
    
    @State var selectedLine: LineModel?
    @State var isSheetPresented = true
    @State var allLines: [LineModel] = []
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            MapReader{ proxy in
                Map(position: $viewModel.position)
            }
                MapCenteringButton(position: $viewModel.position)
        }
        .sheet(isPresented: $isSheetPresented) {
            InitialSheetView(selectedLine: $selectedLine)
        }
    }
}

#Preview {
    ContentView()
}
