//
//  CardItem.swift
//  MealsApps
//
//  Created by Ari Supriatna on 25/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

struct CardItem: View {
    var total: Int = 24
    var title: String = "Events"
    
    var body: some View {
        VStack {
            Text("\(total)")
                .font(.system(size: 24, weight: .medium, design: .rounded))
            Text(title)
                .foregroundColor(.secondary)
                .padding(.vertical, 6)
        }
        .frame(width: 100, height: 100)
        .background(Color("card"))
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
    }
}

struct CardItem_Previews: PreviewProvider {
    static var previews: some View {
        CardItem()
    }
}
