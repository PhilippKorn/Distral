//
//  Hand.swift
//  Distral
//
//  Created by Philipp Korn on 20.02.24.
//

import Foundation
enum Hand: String, CaseIterable, Identifiable {
    case links = "Links"
    case rechts = "Rechts"
    var id: Self { self }
}

