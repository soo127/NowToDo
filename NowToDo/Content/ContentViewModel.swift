//
//  ContentViewModel.swift
//  NowToDo
//
//  Created by 이상수 on 5/11/25.
//

import SwiftUI

class ContentViewModel: ObservableObject {

    @Published var items: [ToDoItem] = [] {
        didSet {
            save()
        }
    }
    private var timer: Timer?
    private var idsForRemoving: Set<UUID> = .init()
    private let key = "items"

    init() {
        load()
    }

    func append() {
        items.append(.empty)
    }

    func toggleRemoval(for id: UUID) {
        if idsForRemoving.contains(id) {
            idsForRemoving.remove(id)
        } else {
            idsForRemoving.insert(id)
        }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            Task { @MainActor in
                self.remove(ids: self.idsForRemoving)
                self.idsForRemoving.removeAll()
            }
        }
    }

    private func remove(ids: Set<UUID>) {
        items.removeAll { ids.contains($0.id) }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let savedItems = try? JSONDecoder().decode([ToDoItem].self, from: data) else {
            return
        }
        self.items = savedItems
    }

}
