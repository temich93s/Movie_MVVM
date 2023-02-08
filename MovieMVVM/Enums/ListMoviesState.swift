// ListMoviesState.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Состояния экрана со списком фильмов
enum ListMoviesState<Model> {
    case initial
    case loading
    //   case successDataStorage([Model])
    case success([Model])
    case failure(Error)
}
