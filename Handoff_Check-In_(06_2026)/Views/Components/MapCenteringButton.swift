//
//  MapCenteringButton.swift
//  Handoff_Check-In_(06_2026)
//
//  Created by Jonas Fernando Nascimento Melo on 22/06/26.
//

import SwiftUI
import MapKit

struct MapCenteringButton: View {
    @Binding var position: MapCameraPosition
    
    var body: some View {
        Button {
            withAnimation {
                position = .userLocation(fallback: .automatic)
            }
        } label: {
            Image(systemName: "location")
                .foregroundStyle(.foregroundSecondary)
                .font(.system(size: 20))
                .frame(width: 44,height: 44)
                .glassEffect(in: .rect(cornerRadius: 8))
        }
        
    }
}

#Preview {
    @Previewable @State var position = MapCameraPosition.automatic
    MapCenteringButton(position: $position)
}
