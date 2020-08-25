//
//  ProfileView.swift
//  MealsApps
//
//  Created by Ari Supriatna on 25/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack {
                imageProfile
                username
                badgePremium
                boxHorizontal
                menuSettings
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .background(RoundedCorners(tl: 30, tr: 30, bl: 0, br: 0).fill(Color("card")))
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: -5)
            }
            .navigationBarTitle(Text("Profile"))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView {
    var imageProfile: some View {
        WebImage(url: URL(string: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80"))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: 250)
            .clipShape(Circle())
    }
    
    var username: some View {
        Text("Katsumi Keinara Mayu")
            .font(.system(size: 24, weight: .semibold, design: .rounded))
            .padding(8)
    }
    
    var badgePremium: some View {
        ZStack {
            Color("card")
                .frame(width: 150, height: 35)
                .cornerRadius(30)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
            
            Text("Premium")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(Color.orange)
                .offset(x: 16)
            
            Image("trophy")
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .offset(x: -50, y: -10)
        }
        .padding(.top)
    }
    
    var divider: some View {
        Divider()
            .padding(.leading)
    }
    
    var spacer: some View {
        Spacer()
    }
    
    var menuSettings: some View {
        VStack {
            NavigationLink(destination: Text("Notifications")) {
                SettingItemRow(image: "notification", title: "Notifications")
            }
            divider
            NavigationLink(destination: Text("Payment Settings")) {
                SettingItemRow(image: "card", title: "Payment settings")
            }
            divider
            NavigationLink(destination: Text("Settings apps")) {
                SettingItemRow(image: "settings", title: "Setting apps")
            }
            divider
        }
        .offset(y: -20)
    }
    
    var boxHorizontal: some View {
        HStack {
            spacer
            CardItem(total: 24, title: "Academy")
            spacer
            CardItem(total: 20, title: "Challenge")
            spacer
            CardItem(total: 30, title: "Events")
            spacer
        }
        .padding(.vertical, 24)
    }
}
