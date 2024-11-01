//
//  MainTableView.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel: MainTabViewModel
    @EnvironmentObject private var coordinator: AppCoordinator
    
    init(viewModel: MainTabViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        
        UINavigationBar.appearance().prefersLargeTitles = false
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .label
    }
    
    var body: some View {
        TabView {
            HomeTab()
                .tabItem {
                    Label("Home".localised, systemImage: "house.fill")
                }
            
            ScheduleTab()
                .tabItem {
                    Label("Schedule".localised, systemImage: "calendar")
                }
            
            PaymentsTab()
                .tabItem {
                    Label("Payments".localised, systemImage: "creditcard.fill")
                }
            
            ProfileTab()
                .tabItem {
                    Label("Profile".localised, systemImage: "person.fill")
                }
        }
        .sheet(isPresented: $viewModel.showNotifications) {
            NotificationsView()
        }
    }
    
    private func HomeTab() -> some View {
        NavigationStack {
            HomeView()
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.showNotifications = true
                        } label: {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.white)
                        }
                    }
                }
        }
    }
    
    private func ScheduleTab() -> some View {
        NavigationStack {
            ScheduleView()
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.showNotifications = true
                        } label: {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.white)
                        }
                    }
                }
        }
    }
    
    private func ProfileTab() -> some View {
        NavigationStack(path: $coordinator.path) {
            ProfileView()
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.showNotifications = true
                        } label: {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.white)
                        }
                    }
                }
                .navigationDestination(for: AppCoordinator.Route.self) { route in
                    switch route {
                    case .editProfile:
                        coordinator.handleEditProfile()
                    case .settings:
                        coordinator.handleSettings()
                    default:
                        EmptyView()
                    }
                }
        }
    }
    
    private func PaymentsTab() -> some View {
        NavigationStack {
            PaymentsView()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.showNotifications = true
                        } label: {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.white)
                        }
                    }
                }
        }
    }
}

#Preview {
    MainTabView(viewModel: MainTabViewModel())
        .environmentObject(AppCoordinator())
}
