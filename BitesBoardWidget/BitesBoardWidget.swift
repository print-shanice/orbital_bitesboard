//
//  BitesBoardWidget.swift
//  BitesBoardWidget
//
//  Created by lai shanice on 16/7/25.
//

import WidgetKit
import SwiftUI

@main
struct BitesBoardWidget: WidgetBundle {
    var body: some Widget {
        LastReviewWidget()

        BitesBoardWidgetLiveActivity()
    }
}
