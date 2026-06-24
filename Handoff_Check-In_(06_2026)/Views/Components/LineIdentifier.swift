//
//  LineIdentifier .swift
//  Handoff_Check-In_(06_2026)
//
//  Created by Jonas Fernando Nascimento Melo on 22/06/26.
//

import SwiftUI

struct LineIdentifier: View {
    let lineNumber: String
    let lineType: Int
    let lineColor:  Color
    var body: some View {
        Text("\(lineNumber)-\(lineType)")
            .foregroundStyle(.foregroundWhite)
            .bold()
            .frame(width: 90,height: 44)
            .font(.system(size: 16))
            .background{
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 90,height: 44)
                    .foregroundStyle(lineColor)
            }
    }
}

#Preview {
    let lineNumber = "6913-10"
    let lineColor: Color = .zoningLightBlue
    let lineType = 10
    LineIdentifier(lineNumber: lineNumber, lineType: lineType, lineColor: lineColor)
}
