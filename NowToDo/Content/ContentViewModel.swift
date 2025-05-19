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
    private func itemIndex(of id: UUID) -> Int? {
        guard let index = items.firstIndex(where: {$0.id == id}) else { return nil }
        return index
    }

    init() {
        load()
    }

    // MARK: - Action in Menu

    func handle(action: MenuAction) {

        switch action {

        case .alignByCreationDate:
            alignMode = .creationDate
        case .alignByDueDate:
            alignMode = .dueDate
        case .showCompleted:
            showCompleted = true

        }

    }

    private func sort() {
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

    func append() {
        items.append(.empty)
    }

    // MARK: - Action in DoneCell

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

    private func toggleRemoveForDone(for id: UUID) {
        if idsForRemovingDone.contains(id) {
            idsForRemovingDone.remove(id)
        } else {
            idsForRemovingDone.insert(id)
        }
    }

    private func remove() {
        completedItems.removeAll { idsForRemovingDone.contains($0.id) }
    }

    // MARK: - Action in ToDoCell

    func handle(action: ToDoCellViewAction) {

        switch action {

        case .notify(let index, let dayAfter):
            requestScheduleNotification(at: index, dayAfter: dayAfter)
        case .onClick(let id):
            toggleCompletion(for: id)
        case .remove(let id):
            remove(for: id)
        case .cancel(let id):
            cancel(for: id)

        }

    }

    private func requestScheduleNotification(at index: Int, dayAfter: Int) {

        items[index].dayAfter = dayAfter

        let content = UNMutableNotificationContent()
        content.title = "Todo 알림"
        content.body = items[index].text
        content.sound = .default

//        let trigger = UNTimeIntervalNotificationTrigger(
//            timeInterval: 5,
//            repeats: false
//        )

        let nDayAfter = Calendar.current.date(byAdding: .day, value: dayAfter, to: now)!
        let components = Calendar.current.dateComponents([.year, .month, .day], from: nDayAfter)
        print(now)
        print(nDayAfter)
        print(components)
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: items[index].id.uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("알림 등록 실패: \(error)")
            } else {
                print("\(dayAfter)일 후 알림 등록 완료")
            }
        }

    }

    private func toggleCompletion(for id: UUID) {
        guard let index = itemIndex(of: id) else { return }
        if idsCompletedSoon.contains(id) {
            idsCompletedSoon.remove(id)
            items[index].completedAt = nil
        } else {
            idsCompletedSoon.insert(id)
            items[index].completedAt = now
        }
        reserveCompletion()
    }

    private func reserveCompletion() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            Task { @MainActor in
                self.moveToCompletedItems(ids: self.idsCompletedSoon)
                self.idsCompletedSoon.removeAll()
            }
        }
    }

    private func moveToCompletedItems(ids: Set<UUID>) {
        let completed = items.filter { ids.contains($0.id) }
        completedItems.append(contentsOf: completed)
        items.removeAll { ids.contains($0.id) }
    }

    private func remove(for id: UUID) {
        guard let index = itemIndex(of: id) else { return }
        items.remove(at: index)
    }

    private func cancel(for id: UUID) {
        guard let index = itemIndex(of: id) else { return }
        items[index].dayAfter = -1
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
        print("알림이 취소되었어요.")
    }

    // MARK: - UserDefaults

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
