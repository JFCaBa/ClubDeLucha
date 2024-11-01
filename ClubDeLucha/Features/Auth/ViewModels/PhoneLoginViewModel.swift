//
//  PhoneLoginViewModel.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//

import Foundation
import Combine

@MainActor
final class PhoneLoginViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: String?
    @Published var isAuthenticated = false
    
    private let authService: AuthServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func login(phoneNumber: String) {
        isLoading = true
        error = nil
        
        authService.login(phoneNumber: phoneNumber)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] _ in
                self?.isAuthenticated = true
            }
            .store(in: &cancellables)
    }
}
