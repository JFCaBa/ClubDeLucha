//
//  HomeViewModel.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var qrCode: QRCode?
    @Published private(set) var isLoading = false
    @Published var error: String?
    
    private let qrCodeService: QRCodeServiceProtocol
    private var refreshTask: Task<Void, Never>?
    
    init(qrCodeService: QRCodeServiceProtocol) {
        self.qrCodeService = qrCodeService
        startQRCodeRefresh()
    }
    
    func startQRCodeRefresh() {
        refreshTask?.cancel()
        refreshTask = Task { [weak self] in
            while !Task.isCancelled {
                await self?.fetchQRCode()
                try? await Task.sleep(nanoseconds: 270_000_000_000) // Refresh every 4.5 minutes
            }
        }
    }
    
    func fetchQRCode() async {
        guard !isLoading else { return }
        isLoading = true
        error = nil
        
        do {
            qrCode = try await qrCodeService.fetchQRCode()
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
    
    deinit {
        refreshTask?.cancel()
    }
}
