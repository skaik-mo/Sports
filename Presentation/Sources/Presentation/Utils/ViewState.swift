//
//  ViewState.swift
//  Presentation
//
//  Created by Mohammed Skaik on 08/07/2026.
//


enum ViewState<T> {
    case loading
    case success(T)
    case empty
    case failure(String)
}
