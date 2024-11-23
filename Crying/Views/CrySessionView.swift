//
//  CrySessionView.swift
//  Crying
//
//  Created by Stephanie Ananth on 11/23/24.
//

//import CoreLocation
import MapKit
import SwiftUI

struct CrySessionView: View {
    let crySession: CrySession

    var body: some View {
        VStack {
            Form {
                Section("When") {
                    Text("\(crySession.date.weekday), \(crySession.date.formatted(date: .long, time: .omitted)) at \(crySession.date.formatted(date: .omitted, time: .shortened))")
                }

                Section("Where") {
                    if let location = crySession.location {
                        Map {
                            Marker(crySession.locationName, coordinate: location)
                        }
                        .frame(height: UIScreen.main.bounds.width / 3)
                        .scaledToFill()
                    } else {
                        Text(crySession.locationName)
                    }
                }

                Section("Why") {
                    if let notes = crySession.notes {
                        Text(notes)
                    }
                }

                Section("How") {
                    HStack {
                        ForEach(1...5, id: \.self) { rating in
                            Image(systemName: "drop\(rating > crySession.value ? "" : ".fill")")
                        }
                    }
                    .foregroundStyle(.blue)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CrySessionView(crySession: CrySession())
    }
}

fileprivate extension Date {
    var weekday: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
}
