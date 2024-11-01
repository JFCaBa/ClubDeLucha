//
//  ProfileView.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @State private var showLogoutConfirmation = false
    @EnvironmentObject private var coordinator: AppCoordinator
    
    private let menuItems = [
        MenuItem(title: "Edit Profile".localised, icon: "person.circle", action: .editProfile),
        MenuItem(title: "Settings".localised, icon: "gearshape.fill", action: .settings)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            profileHeader
            Spacer()
            menuList
        }
        .padding(.top, 20)
        .navigationTitle("Profile".localised)
    }
    
    private var profileHeader: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                Text("John Doe".localised)
                    .font(.title2)
                    .bold()
                Text("Madrid, Spain")
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
    
    private func menuRow(_ item: MenuItem) -> some View {
        NavigationLink(value: item.action) {
            VStack(spacing: 0) {
                Spacer()
                HStack {
                    Image(systemName: item.icon)
                        .frame(width: 24)
                    Text(item.title)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)
            .foregroundColor(.secondary)
        }
    }
    
    private var menuList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(menuItems) { item in
                    menuRow(item)
                }
                
                Spacer()
                
                HStack(spacing: 0) {
                    Spacer()
                    
                    Button("Log Out".localised) {
                        showLogoutConfirmation = true
                    }
                    .foregroundColor(.red)
                    .confirmationDialog("confirm_logout".localised, isPresented: $showLogoutConfirmation) {
                        Button("Log Out".localised, role: .destructive) {
                            coordinator.authenticationState = .notAuthenticated
                        }
                        Button("Cancel".localised, role: .cancel) {}
                    }
                    
                    Spacer()
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
            }
            .padding()
        }
    }
}

#Preview {
    ProfileView()
        .withTestDependencies()
}
