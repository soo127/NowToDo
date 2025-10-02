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
    @Published var doneItems: [ToDoItem] = [] {
        didSet {
            saveDoneItems()
        }
    }
    @Published var alarmedItems: [ToDoItem] = [] {
        didSet {
            saveAlarmedItems()
        }
    }
    @Published var alignMode: AlignMode = .creationDate {
        didSet {
            sort()
        }
    }
    @Published var showDoneCells: Bool = false
    @Published var sheetType: SheetType? = nil
    @Published var historyType: HistoryType? = nil
    @Published var alertType: AlertType? = nil


    private var timer: Timer?
    private var now: Date { Date() }

    private var idsDoneSoon: Set<UUID> = .init()
    private var doneIds: Set<UUID> = .init()
    private var alarmedIds: Set<UUID> = .init()

    init() {
        load()
    }

    // MARK: - Action in Menu

    func handle(action: MenuType) {
        switch action {
        case .alignByCreationDate:
            alignMode = .creationDate
        case .alignByDueDate:
            alignMode = .dueDate
        case .showDoneCells:
            historyType = .done
        case .showSoundedAlarms:
            historyType = .alarmed
        }
    }

    private func sort() {
        if alignMode == .creationDate {
            items.sort { $0.createdDate < $1.createdDate }

        } else { // alignMode == .dueDate
            items.sort {
                switch ($0.dueDate, $1.dueDate) {

                case let (d1?, d2?):
                    if d1 == d2 {
                        return $0.createdDate < $1.createdDate
                    } else {
                        return d1 < d2
                    }

                case (.none, .none):
                    return $0.createdDate < $1.createdDate

                case (.none, .some):
                    return false

                case (.some, .none):
                    return true
                }
            }
        }
    }

    func items(type: HistoryType) -> [ToDoItem] {
        if type == .alarmed {
            return alarmedItems
        } else {
            return doneItems
        }
    }

    func handle(type: HistoryType, action: HistoryContainerAction) {
        switch type {
        case .alarmed:
            handle(alarmedAction: action)
        case .done:
            handle(doneAction: action)
        }
    }

    // MARK: - Action in DoneCell

    func handle(doneAction: HistoryContainerAction) {
        switch doneAction {

        case .dismiss:
            historyType = nil
        case .click(let id):
            toggleRemoveForDone(for: id)
        case .remove:
            removeDone()

        }
    }

    private func toggleRemoveForDone(for id: UUID) {
        if doneIds.contains(id) {
            doneIds.remove(id)
        } else {
            doneIds.insert(id)
        }
    }

    private func removeDone() {
        doneItems.removeAll { doneIds.contains($0.id) }
    }

    // MARK: - Action in AlarmedCell

    func handle(alarmedAction: HistoryContainerAction) {
        switch alarmedAction {

        case .dismiss:
            historyType = nil
        case .click(let id):
            toggleRemoveForAlarmed(for: id)
        case .remove:
            removeAlarmed()

        }
    }

    private func toggleRemoveForAlarmed(for id: UUID) {
        if alarmedIds.contains(id) {
            alarmedIds.remove(id)
        } else {
            alarmedIds.insert(id)
        }
    }

    private func removeAlarmed() {
        alarmedItems.removeAll { alarmedIds.contains($0.id) }
    }

    // MARK: - Action in ToDoCell

    func handle(action: ToDoContainerAction) {
        switch action {

        case .notify(let id, let alarmDate):
            notify(for: id, alarmDate: alarmDate)
        case .setDueDate(let id, let dueDate):
            setDueDate(for: id, dueDate: dueDate)
        case .click(let id):
            toggleDone(for: id)
        case .remove(let id):
            remove(for: id)
        case .cancelAlarm(let id):
            cancelAlarm(for: id)
        case .removeDueDate(let id):
            removeDueDate(for: id)
        case .moveExpiredAlarms:
            moveExpiredAlarms()

        }
    }

    private func notify(for id: UUID, alarmDate: Date) {
        sheetType = nil

        UNUserNotificationCenter.current().getNotificationSettings { settings in
            
            guard settings.authorizationStatus == .authorized else {
                self.alertType = .permissionDenied
                return
            }
            
            if self.isImpossibleAlarm(alarmDate: alarmDate) {
                self.alertType = .pastAlarm
                return
            }
            self.setNotification(for: id, alarmDate: alarmDate)
        }
        
    }

    private func isImpossibleAlarm(alarmDate: Date) -> Bool {
        return now >= alarmDate ? true : false
    }

    private func setNotification(for id: UUID, alarmDate: Date) {
        guard let index = items.firstIndex(where: { $0.id == id }) else {
            return
        }
        cancelAlarm(for: id)
        items[index].alarmDate = alarmDate

        let content = UNMutableNotificationContent()
        content.title = "Todo 알림"
        content.body = items[index].text
        content.sound = .default

        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: alarmDate)
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: items[index].id.uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
        checkAlarmIsLate(dueDate: items[index].dueDate, alarmDate: alarmDate)
    }

    private func checkAlarmIsLate(dueDate: Date?, alarmDate: Date) {
        if let dueDate = dueDate, alarmDate > dueDate {
            alertType = .dueDatePassed
        }
    }

    private func setDueDate(for id: UUID, dueDate: Date) {
        sheetType = nil

        guard let index = items.firstIndex(where: { $0.id == id }) else {
            return
        }

        items[index].dueDate = dueDate
        if let alarmDate = items[index].alarmDate, alarmDate > dueDate {
            alertType = .dueDatePassed
        }
    }

    private func toggleDone(for id: UUID) {
        guard let index = items.firstIndex(where: { $0.id == id }) else {
            return
        }

        if idsDoneSoon.contains(id) {
            idsDoneSoon.remove(id)
            items[index].doneDate = nil
        } else {
            idsDoneSoon.insert(id)
            items[index].doneDate = now
        }
        reserveDone()
    }

    private func reserveDone() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            Task { @MainActor in
                self.moveToDoneItems(ids: self.idsDoneSoon)
                self.idsDoneSoon.removeAll()
            }
        }
    }

    private func moveToDoneItems(ids: Set<UUID>) {
        let done = items.filter { ids.contains($0.id) }
        ids.forEach { id in
            cancelAlarm(for: id)
        }
        doneItems.append(contentsOf: done)
        items.removeAll { ids.contains($0.id) }
    }

    private func remove(for id: UUID) {
        guard let index = items.firstIndex(where: { $0.id == id }) else {
            return
        }
        cancelAlarm(for: id)
        items.remove(at: index)
    }

    private func cancelAlarm(for id: UUID) {
        defer { sheetType = nil }

        guard let index = items.firstIndex(where: { $0.id == id }) else {
            return
        }

        items[index].alarmDate = nil
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
    }

    private func removeDueDate(for id: UUID) {
        defer { sheetType = nil }

        guard let index = items.firstIndex(where: { $0.id == id }) else {
            return
        }

        items[index].dueDate = nil
    }

    private func moveExpiredAlarms() {
        for index in items.indices {
            if let alarmDate = items[index].alarmDate, alarmDate <= now {
                alarmedItems.append(items[index])
                items[index].alarmDate = nil
            }
        }
    }

    // MARK: - Action in FooterView

    func append() {
        items.append(.empty)
    }

    // MARK: - UserDefaults

    private func saveItems() {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: UserDefaultsKey.items)
        }
    }

    private func saveDoneItems() {
        if let data = try? JSONEncoder().encode(doneItems) {
            UserDefaults.standard.set(data, forKey: UserDefaultsKey.doneItems)
        }
    }

    private func saveAlarmedItems() {
        if let data = try? JSONEncoder().encode(alarmedItems) {
            UserDefaults.standard.set(data, forKey: UserDefaultsKey.doneItems)
        }
    }


    private func load() {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultsKey.items),
              let savedItems = try? JSONDecoder().decode([ToDoItem].self, from: data) else {
            return
        }
        self.items = savedItems

        guard let data = UserDefaults.standard.data(forKey: UserDefaultsKey.doneItems),
              let savedItems = try? JSONDecoder().decode([ToDoItem].self, from: data) else {
            return
        }
        self.doneItems = savedItems

        guard let data = UserDefaults.standard.data(forKey: UserDefaultsKey.alarmedItems),
              let savedItems = try? JSONDecoder().decode([ToDoItem].self, from: data) else {
            return
        }
        self.alarmedItems = savedItems
    }

}
