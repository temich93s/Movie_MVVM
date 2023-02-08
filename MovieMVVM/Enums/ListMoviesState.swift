// ListMoviesState.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Состояния экрана со списком фильмов
enum ListMoviesState {
    case initial
    case loading
    case success
    case failure(Error)
}
