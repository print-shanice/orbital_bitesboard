//
//  HomepageBarView.swift
//  BitesBoard
//
//  Created by lai shanice on 9/6/25.
//
//import SwiftUI
//
//enum HomepageColumn: String, CaseIterable {
//    case following = "Following"
//    case friends = "Friends"
//    case forYou = "For you"
//    case favourites = "Favourites"
//}
//
//struct HomepageBarView: View {
//    @Binding var selectedColumn: HomepageColumn
//    
//    var body: some View {
//        HStack {
//            ForEach(HomepageColumn.allCases, id: \.self) { column in
//                Button(action: {
//                    selectedColumn = column
//                }) {
//                    VStack {
//                        Text(column.rawValue)
//                            .fontWeight(selectedColumn == column ? .bold : .regular)
//                            .foregroundColor(selectedColumn == column ? .red : .gray)
//                        if selectedColumn == column {
//                            Rectangle()
//                                .frame(height: 2)
//                                .foregroundColor(.red)
//                        } else {
//                            Rectangle()
//                                .frame(height: 2)
//                                .foregroundColor(.clear)
//                        }
//                    }
//                }
//                .frame(maxWidth: .infinity)
//            }
//        }
//        .padding(.horizontal)
//        .padding(.top)
//    }
//}
//
//struct HomepageBarView_Previews: PreviewProvider {
//    struct PreviewWrapper: View {
//        @State private var selectedColumn: HomepageColumn = .following
//            
//        var body: some View {
//            HomepageBarView(selectedColumn: $selectedColumn)
//        }
//    }
//
//    static var previews: some View {
//        PreviewWrapper()
//    }
//}
