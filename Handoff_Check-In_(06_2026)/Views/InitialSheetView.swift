//
//  InitialSheetView.swift
//  Handoff_Check-In_(06_2026)
//
//  Created by Jonas Fernando Nascimento Melo on 22/06/26.
//

import SwiftUI

struct InitialSheetView: View {
    @State private var viewModel = InitialSheetViewModel()
    @State private var showAllert = false
    @State private var fractionShowing = 0.1
    @State private var searchText = ""
    @Binding var selectedLine: LineModel?
    
    @State var openAlertLine: LineModel?
    @State var lines: [LineModel] = []
    @State var stopCounts: [Int: Int] = [:]
    
    var body: some View {
        NavigationStack {
            VStack{
                if lines.isEmpty {
                    Image(systemName: "bus")
                        .font(.system(size: 41))
                        .foregroundStyle(.foregroundPrimary)
                        .padding(.bottom, 16)
                    Text("Nenhuma Linha Encontrada")
                        .font(.system(size: 22))
                        .foregroundStyle(.foregroundPrimary)
                        .fontWeight(.semibold)
                    Text("Pesquise alguma linha ou destino de seu ônibus")
                        .font(.system(size: 22))
                        .foregroundStyle(.foregroundSecondary)
                        .multilineTextAlignment(.center)
                        .fontWeight(.medium)
                }
                
                ScrollView{
                    ForEach(lines, id: \.cl) { line in
                        LineCard(line: line, stops: stopCounts[line.cl] ?? 0)
                            .onTapGesture {
                                openAlertLine = line
                            }
                        Divider()
                            .padding(.horizontal, UIScreen.main.bounds.width * 0.1)
                    }
                    .id(lines.map(\.cl))
                    .alert("Deseja Selecionar essa linha?)", isPresented: .init(get: { openAlertLine != nil },set: { if !$0 { openAlertLine = nil } })) {
                        Button("Sim") {selectedLine = openAlertLine}
                            .buttonStyle(.borderedProminent)
                        Button("Não", role: .cancel) { selectedLine = nil }
                    } message: {
                        Text("Ao seleciona-la, você verá a posição dos pontos e os ônibus em operação no mapa.")
                        
                    }
                }
                .scrollIndicators(.hidden)
                
            }
            .onChange(of: searchText){
                Task {
                    lines = try await viewModel.searchLines(text: searchText)
                    for line in lines {
                        let count = try await viewModel.lineStops(lineCode: line.cl).count
                        stopCounts[line.cl] = count
                    }
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .presentationDetents([.fraction(fractionShowing), .medium, .large])
        .interactiveDismissDisabled(true)
    }
}

#Preview {
    ContentView()
}
