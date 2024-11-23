//
//  ContentView.swift
//  Crying
//
//  Created by Stephanie Ananth on 11/23/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var crySessions: [CrySession]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(crySessions) { crySession in
                    NavigationLink {
                        CrySessionView(crySession: crySession)
                    } label: {
                        HStack {
                            Text(crySession.date.formatted(date: .numeric, time: .omitted))
                            Spacer()
                            HStack {
                                ForEach(1...5, id: \.self) { rating in
                                    Image(systemName: "drop\(rating > crySession.value ? "" : ".fill")")
                                }
                            }
                            .foregroundStyle(.blue)
                        }
                    }
                }
                .onDelete(perform: deleteCrySessions)
            }
            #if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            #endif
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                #endif
                ToolbarItem {
                    Button(action: addCrySession) {
                        Image(systemName: "plus")
                    }
                }
            }
        } detail: {
            Text("Select a cry session")
        }
    }

    private func addCrySession() {
        withAnimation {
            let newItem = CrySession()
            modelContext.insert(newItem)
        }
    }

    private func deleteCrySessions(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(crySessions[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: CrySession.self, inMemory: true)
}
