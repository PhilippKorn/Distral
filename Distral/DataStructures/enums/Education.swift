//
//  Education.swift
//  Distral
//
//  Created by Philipp Korn on 20.02.24.
//

import Foundation

enum Education: String, CaseIterable, Identifiable {
    case special_school = "Förderschule",
         board_school = "Volksschule",
         main_school = "Haupttschule",
         middle_school = "Mittlere Reife",
         vocational_baccalaureate_diploma = "Fachabitur",
         high_school_diploma = "Abitur",
         other = "Andere"
    var id: Self { self }
}
