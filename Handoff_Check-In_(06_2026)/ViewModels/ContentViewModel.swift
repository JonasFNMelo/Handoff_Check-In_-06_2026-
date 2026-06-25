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
    var userLocation: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    var position: MapCameraPosition = .userLocation(fallback: .automatic)

    private let baseURL = URL(string: "https://api.olhovivo.sptrans.com.br/v2.1")!
    private let session: URLSession
    private var isAuthenticated = false
    
    init() {
        let config = URLSessionConfiguration.default
        config.httpCookieStorage = HTTPCookieStorage.shared
        config.httpShouldSetCookies = true
        self.session = URLSession(configuration: config)
        requestUserLocationAutorization()
    }
    
    // MARK: - Request Users Location
    
    func requestUserLocationAutorization(){
        locationManager.requestWhenInUseAuthorization()
        if let location = locationManager.location?.coordinate {
            userLocation = location
        }
    }
    
    // MARK: - Authentication
    
    private func ensureAuthenticated() async throws {
        guard !isAuthenticated else { return }
        isAuthenticated = try await authenticate()
        if !isAuthenticated {
            throw URLError(.userAuthenticationRequired)
        }
    }
    
    private func authenticate() async throws -> Bool {
//        let token = ProcessInfo.processInfo.environment["SPTRANS_TOKEN"] ?? ""
        let token = "d77cd4875ff1867726ffbb62cae1aacbe24176190a8a6a76057b45ce6569e1f2"
        guard let url = URL(string: "\(baseURL)/Login/Autenticar?token=\(token)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await session.data(for: request)
        let authenticated = try JSONDecoder().decode(Bool.self, from: data)
        print("Authenticated: \(authenticated)")
        return authenticated
    }
    func getActualLocation() -> CLLocation? {
        locationManager.requestLocation()
        return locationManager.location
    }
    
    
    // MARK: - Stops
    
    func lineStops(lineCode: Int) async throws -> [Stop] {
        try await ensureAuthenticated()
        
        guard let url = URL(string: "\(baseURL)/Parada/BuscarParadasPorLinha?codigoLinha=\(lineCode)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode([Stop].self, from: data)
    }
    
    // MARK: - Bus Position
    
    func busPosition(lineCode: Int) async throws -> LinePosition {
        try await ensureAuthenticated()
        
        guard let url = URL(string: "\(baseURL)/Posicao/Linha?codigoLinha=\(lineCode)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode(LinePosition.self, from: data)
    }
    
    func allBusPositions() async throws -> Data {
        try await ensureAuthenticated()
        
        guard let url = URL(string: "\(baseURL)/Posicao") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await session.data(from: url)
        return data
    }
}
