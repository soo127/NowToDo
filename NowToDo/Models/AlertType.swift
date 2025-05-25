//
//  AlertType.swift
//  NowToDo
//
//  Created by 이상수 on 5/22/25.
//

enum AlertType: Identifiable {

    case pastAlarm
    case permissionDenied
    case dueDatePassed

    var id: Int {
        hashValue
    }

    var message: String {
        switch self {
        case .pastAlarm:
            return "과거에 알림을 설정할 수 없습니다."
        case .permissionDenied:
            return "설정에서 알림 권한을 허용해주세요."
        case .dueDatePassed:
            return "해당 ToDo는 마감 이후 알람이 울립니다."
        }
    }

}

