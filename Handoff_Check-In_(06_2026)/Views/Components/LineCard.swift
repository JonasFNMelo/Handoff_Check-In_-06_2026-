//
//  LineCard .swift
//  Handoff_Check-In_(06_2026)
//
//  Created by Jonas Fernando Nascimento Melo on 22/06/26.
//

import SwiftUI

struct LineCard: View {
    let lineNumber: String
    let lineColor: Color
    var mainTerminal: String
    var secondaryTerminal: String
    var numOfStops: Int
    var isCircular: Bool
    var body: some View {
        HStack(spacing: 8){
            LineIdentifier(lineNumber: lineNumber, lineColor: lineColor)
            
            VStack(alignment: .leading){
                Text(mainTerminal)
                    .fontWeight(.medium)
                    .font(.system(size: 16))
                    .foregroundStyle(.foregroundSecondary)
                Text(secondaryTerminal)
                    .fontWeight(.medium)
                    .font(.system(size: 16))
                    .foregroundStyle(.foregroundSecondary)
            }
            
            Spacer()
        }
        .overlay {
            HStack{
                Spacer()
                
                VStack(alignment: .trailing){
                    Text("\(numOfStops) paradas")
                        .fontWeight(.regular)
                        .font(.system(size: 12))
                        .foregroundStyle(.foregroundSecondary)
                    if isCircular {
                        Image(systemName: "arrow.clockwise.circle")
                            .foregroundStyle(.compassRed)
                            .frame(width: 15,height: 15)
                    }
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 15)
    }
}

#Preview {
    let lineNumber = "6913-10"
    let lineColor: Color = .zoningLightBlue
    var mainTerminal: String = "Itaim Bibi"
    var secondaryTerminal: String = "Term. Varginha"
    var numOfStops = 82

    LineCard(lineNumber: lineNumber, lineColor: lineColor,
             mainTerminal: mainTerminal, secondaryTerminal: secondaryTerminal,
             numOfStops: numOfStops, isCircular: true)
}
