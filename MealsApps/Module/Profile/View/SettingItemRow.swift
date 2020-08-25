//
//  SettingItemRow.swift
//  MealsApps
//
//  Created by Ari Supriatna on 25/08/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

struct SettingItemRow: View {
    var image: String = "settings"
    var title: String = "Settings Apps"
    
    var body: some View {
        HStack {
            Image(image)
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
            
            Text(title)
                .foregroundColor(.primary)
                .font(.system(size: 18, weight: .medium, design: .rounded))
            
            Spacer()
            
            Image(systemName: "chevron.right")
            
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct SettingItemRow_Previews: PreviewProvider {
    static var previews: some View {
        SettingItemRow()
    }
}
