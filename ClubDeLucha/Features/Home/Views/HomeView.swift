//
//  HomeView.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    @Environment(\.scenePhase) private var scenePhase
    
    init() {
        _viewModel = StateObject(wrappedValue: HomeViewModel(qrCodeService: DependencyContainer.shared.makeQRCodeService()))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .padding()
            } else if let qrCode = viewModel.qrCode {
                Image("club_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.5)
                    .padding(.top, 5)
                
                QRCodeView(url: qrCode.url)
                    .frame(width: 250, height: 250)
                
                Text("QR Code expires in:")
                    .font(.headline)
                
                TimelineView(.periodic(from: .now, by: 1.0)) { timeline in
                    Text(qrCode.expiresAt, style: .timer)
                        .font(.title2)
                        .monospacedDigit()
                }
            }
            
            if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Club De Lucha")
                        .font(.headline)
                    Text("Massanassa")
                        .font(.subheadline)
                }
            }
        }
        .onChange(of: scenePhase, { oldValue, newValue in
            if newValue == .active {
                viewModel.startQRCodeRefresh()
            }
        })
    }
}


#Preview {
    HomeView()
        .withTestDependencies()
}
