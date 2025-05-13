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
    @Published var sortMode: SortMode = .creationDate {
        didSet {
            if sortMode == .creationDate {
                items.sort { $0.createdAt < $1.createdAt }
            } else { // sortMode == .dueDate
                items.sort {
                    switch ($0.dueDate, $1.dueDate) {
                        case let (d1?, d2?):
                            if d1 == d2 {
                                return $0.createdAt < $1.createdAt
                            } else {
                                return d1 < d2
                            }

                        case (.none, .none):
                            return $0.createdAt < $1.createdAt

                        case (.none, .some):
                            return false

                        case (.some, .none):
                            return true
                        }
                }
            }
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
