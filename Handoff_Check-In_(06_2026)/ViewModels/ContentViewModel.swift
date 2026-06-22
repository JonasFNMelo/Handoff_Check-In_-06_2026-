//
//  ContentViewModel.swift
//  Handoff_Check-In_(06_2026)
//
//  Created by Jonas Fernando Nascimento Melo on 22/06/26.
//

import SwiftUI
import Foundation
import MapKit

@Observable
class ContentViewModel {
    var locationManager = CLLocationManager()
    let url = URL(string: "http://api.olhovivo.sptrans.com.br/v2.1.")!
    let token = "Login/Autenticar?token={d77cd4875ff1867726ffbb62cae1aacbe24176190a8a6a76057b45ce6569e1f2}"
    var isAuthenticated: Bool = false
    
    func autentication() async {
        guard let encoded = try? JSONEncoder().encode(isAuthenticated) else {
            print("Failed to encode order")
            return
        }
        var request = URLRequest(url: url)
        request.httpBody = Data(token.utf8)
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            isAuthenticated = try JSONDecoder().decode(Bool.self, from: data)
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
        }
    }
    
    func getActualLocation() -> CLLocation? {
        locationManager.requestLocation()
        return locationManager.location
    }
}
