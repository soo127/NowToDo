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
            saveItems()
        }
    }
    @Published var completedItems: [ToDoItem] = [] {
        didSet {
            saveCompletedItems()
        }
    }
    @Published var alignMode: AlignMode = .creationDate {
        didSet {
            sort()
        }
    }
    @Published var showCompleted: Bool = false

    private var timer: Timer?
    private var idsCompletedSoon: Set<UUID> = .init()
    private var idsForRemovingDone: Set<UUID> = .init()
    private let key = "items"
    private let key2 = "completedItems"
    private var now: Date { Date() }

    init() {
        load()
    }

    func sort() {
        if alignMode == .creationDate {
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

    func handle(action: MenuAction) {

        switch action {

        case .alignByCreationDate:
            alignMode = .creationDate
        case .alignByDueDate:
            alignMode = .dueDate
        case .alarm:
            print("미완성")
        case .delete:
            print("미완성")
        case .showCompleted:
            showCompleted = true

        }
    }

    func handle(action: DoneCellViewAction) {

        switch action {

        case .onDismiss:
            showCompleted = false
        case .onClick(let id):
            toggleRemoveForDone(for: id)
        case .onRemove:
            remove()

        }
    }

    func append() {
        items.append(.empty)
    }

    func reserveCompletion() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            Task { @MainActor in
                self.moveToCompletedItems(ids: self.idsCompletedSoon)
                self.idsCompletedSoon.removeAll()
            }
        }
    }

    func remove(for id: UUID) {
        items.remove(at: items.firstIndex(where: {$0.id == id})!)
    }

    func remove() {
        completedItems.removeAll { idsForRemovingDone.contains($0.id) }
    }

    func toggleRemoveForDone(for id: UUID) {
        if idsForRemovingDone.contains(id) {
            idsForRemovingDone.remove(id)
        } else {
            idsForRemovingDone.insert(id)
        }
    }

    func toggleCompletion(for id: UUID) {
        guard let index = items.firstIndex(where: { $0.id == id }) else { return }
        if idsCompletedSoon.contains(id) {
            idsCompletedSoon.remove(id)
            items[index].completedAt = nil
        } else {
            idsCompletedSoon.insert(id)
            items[index].completedAt = now
        }
        reserveCompletion()
    }

    private func moveToCompletedItems(ids: Set<UUID>) {
        let completed = items.filter { ids.contains($0.id) }
        completedItems.append(contentsOf: completed)
        items.removeAll { ids.contains($0.id) }
    }

    private func saveItems() {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func saveCompletedItems() {
        if let data = try? JSONEncoder().encode(completedItems) {
            UserDefaults.standard.set(data, forKey: key2)
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let savedItems = try? JSONDecoder().decode([ToDoItem].self, from: data) else {
            return
        }
        self.items = savedItems

        guard let data = UserDefaults.standard.data(forKey: key2),
              let savedItems = try? JSONDecoder().decode([ToDoItem].self, from: data) else {
            return
        }
        self.completedItems = savedItems
    }

}
