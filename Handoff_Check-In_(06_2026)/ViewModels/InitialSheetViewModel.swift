//
//  InitialSheetViewModel.swift
//  Handoff_Check-In_(06_2026)
//
//  Created by Jonas Fernando Nascimento Melo on 24/06/26.
//

import Foundation

@Observable
class InitialSheetViewModel {
    
    private let baseURL = URL(string: "https://api.olhovivo.sptrans.com.br/v2.1")!
    private let session: URLSession
    private var isAuthenticated = false
    
    init() {
        let config = URLSessionConfiguration.default
        config.httpCookieStorage = HTTPCookieStorage.shared
        config.httpShouldSetCookies = true
        self.session = URLSession(configuration: config)
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
    
    // MARK: - Lines
    
    func searchLines(text: String) async throws -> [LineModel] {
        try await ensureAuthenticated()
        
        let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? text
        guard let url = URL(string: "\(baseURL)/Linha/Buscar?termosBusca=\(encodedText)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await session.data(from: url)
        let lines = try JSONDecoder().decode([LineModel].self, from: data)
        
        return lines
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
}
