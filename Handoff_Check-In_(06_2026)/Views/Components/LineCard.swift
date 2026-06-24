//
//  LineCard .swift
//  Handoff_Check-In_(06_2026)
//
//  Created by Jonas Fernando Nascimento Melo on 22/06/26.
//

import SwiftUI

struct LineCard: View {
    let line: LineModel
    let stops: Int

    var body: some View {
        HStack(spacing: 8){
            LineIdentifier(lineNumber: line.lt, lineType: line.tl, lineColor: .zoningDarkBlue)
            
            VStack(alignment: .leading){
                Text(line.tp)
                    .fontWeight(.medium)
                    .font(.system(size: 16))
                    .foregroundStyle(.foregroundSecondary)
                Text(line.ts)
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
                    Text("\(stops) paradas")
                        .fontWeight(.regular)
                        .font(.system(size: 12))
                        .foregroundStyle(.foregroundSecondary)
                    if line.lc {
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
    let lineModel = LineModel(cl: 1, lc: true, lt: "1", sl: 1, tl: 1, tp: "", ts: "")

    LineCard(line: lineModel, stops: 1)
}
