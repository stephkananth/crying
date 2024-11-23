//
//  CrySession.swift
//  Crying
//
//  Created by Stephanie Ananth on 11/23/24.
//

import CoreLocation
import Foundation
import SwiftData

@Model
final class CrySession: Identifiable {
    var people = ["Stephanie Ananth"]

    var emoji = "😢"

    var date = Date()

    var locationName: String = "My apartment"

    var latitude: Double?
    var longitude: Double?

    var location: CLLocationCoordinate2D? {
        guard let latitude, let longitude else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var notes: String? = "sad about the election and the world"

    var value = 3 {
        willSet {
            if newValue < 1 { value = 1 }
            if newValue > 5 { value = 5 }
        }
    }




    init(date: Date = Date(), value: Int = 3, notes: String? = nil, people: [String] = []) {
        self.date = date
        self.value = value
        if let notes {
            self.notes = notes
        }
        self.people.append(contentsOf: people)
    }
}
