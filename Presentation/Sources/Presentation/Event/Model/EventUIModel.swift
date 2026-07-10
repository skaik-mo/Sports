//
//  EventUIModel.swift
//  Presentation
//
//  Created by Mohammed Skaik on 09/07/2026.
//

struct EventUIModel: Identifiable {
    let id: Int
    let date: String
    let time: String
    let finalResult: String
    let homeTeams: TeamUIModel
    let awayTeams: TeamUIModel
}
