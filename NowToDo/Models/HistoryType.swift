//
//  HistoryType.swift
//  NowToDo
//
//  Created by 이상수 on 5/21/25.
//

import SwiftUI

enum HistoryType: Identifiable {

    case done
    case alarmed

    var id: Int {
        switch self {
        case .done: 0
        case .alarmed: 1
        }
    }

}
