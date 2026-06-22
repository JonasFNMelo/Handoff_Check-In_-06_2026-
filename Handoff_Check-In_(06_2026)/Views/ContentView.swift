//
//  ContentView.swift
//  Handoff_Check-In_(06_2026)
//
//  Created by Jonas Fernando Nascimento Melo on 22/06/26.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var viewModel = ContentViewModel()
    
    @State private var position = MapCameraPosition.automatic
    
    @State var isSheetPresented = true
    
    var body: some View {
        Map(position: $position)
            .sheet(isPresented: $isSheetPresented) {
               InitialSheetView()
            }
            .onAppear{
                Task{
                    await viewModel.autentication()
                }
            }
    }
}

#Preview {
    ContentView()
}
