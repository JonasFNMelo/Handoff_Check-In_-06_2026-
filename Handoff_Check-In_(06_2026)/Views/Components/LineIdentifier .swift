//
//  LineIdentifier .swift
//  Handoff_Check-In_(06_2026)
//
//  Created by Jonas Fernando Nascimento Melo on 22/06/26.
//

import SwiftUI

struct LineIdentifier_: View {
    let lineNumber: String
    let lineColor:  Color
    var body: some View {
        Text(lineNumber)
            .foregroundStyle(.foregroundWhite)
            .bold()
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
    LineIdentifier_(lineNumber: lineNumber, lineColor: lineColor)
}
