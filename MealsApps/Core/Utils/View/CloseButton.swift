//
//  CloseButton.swift
//  MealsApps
//
//  Created by Ari Supriatna on 08/09/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

struct CloseButton: View {

  var body: some View {
    Image(systemName: "xmark")
      .font(.system(size: 17, weight: .bold))
      .foregroundColor(.white)
      .padding(.all, 10)
      .background(Color.black.opacity(0.6))
      .clipShape(Circle())
  }

}

struct CloseButton_Previews: PreviewProvider {
  static var previews: some View {
    CloseButton()
  }
}
