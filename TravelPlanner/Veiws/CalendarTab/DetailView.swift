//
//  DetailView.swift
//  TravelPlanner
//
//  Created by Yosuke Yoshida on 2023/12/05.
//

import SwiftUI

struct EventDetail: View {
    var schedule: ScheduleModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(schedule.title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 4)

            Text(schedule.description)
                .font(.body)
                .foregroundColor(.gray)
                .padding(.bottom, 8)

            Text("開始時刻: \(formattedDate(schedule.startTime))")
                .font(.subheadline)
                .foregroundColor(.blue)

            Text("終了時刻: \(formattedDate(schedule.endTime))")
                .font(.subheadline)
                .foregroundColor(.blue)

            Spacer()
        }
        .padding()
        .navigationBarTitle("イベント詳細", displayMode: .inline)
    }

    // 開始時刻や終了時刻のフォーマットを調整するメソッド
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: date)
    }
}

struct EventDetail_Previews: PreviewProvider {
    static var previews: some View {
        EventDetail(schedule: sampleSchedules[0])
    }
}
