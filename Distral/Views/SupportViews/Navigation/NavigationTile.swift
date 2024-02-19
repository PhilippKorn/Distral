//
//  NavigationTile.swift
//  Impala
//
//  Created by Philipp Korn on 20.10.23.
//

import Foundation
import SwiftUI

struct NavigationTile: View {
    let imageSystemName: String
    let title: String
    var imageColor: Color = .white
    var textColor: Color = .white
    
    var body: some View {
        VStack {
            Image(systemName: imageSystemName)
                .font(.largeTitle)
                .foregroundColor(imageColor)
            Text(title)
                .font(.footnote)
                .foregroundColor(textColor)
                .padding(.vertical)
                .bold()
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(.blue)
        .cornerRadius(15)
        .aspectRatio(1, contentMode: .fit)
    }
}
