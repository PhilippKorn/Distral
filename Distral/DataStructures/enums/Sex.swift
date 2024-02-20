//
//  Sex.swift
//  Distral
//
//  Created by Philipp Korn on 20.02.24.
//

import Foundation
enum Sex: String, CaseIterable, Identifiable {
    case male = "Männlich", female = "Weiblich"
    var id: Self { self }
}
