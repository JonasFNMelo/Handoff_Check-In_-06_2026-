//
//  PointIdentifier.swift
//  Handoff_Check-In_(06_2026)
//
//  Created by Jonas Fernando Nascimento Melo on 22/06/26.
//

import SwiftUI

struct PointIdentifier: View {
    let stopName: String
    let stopAddress: String
    var body: some View {
        VStack(alignment: .leading){
            Text(stopName)
                .foregroundStyle(.foregroundSecondary)
                .font(.system(size: 16))
            Text(stopAddress)
                .foregroundStyle(.foregroundPrimary)
                .font(.system(size: 14))
        }
    }
}

#Preview {
    let stopName: String = "Term. Varginha"
    let stopAddress: String = "Av. Paulo Guilger Reimberg, 13"
    PointIdentifier(stopName: stopName, stopAddress: stopAddress)
}
