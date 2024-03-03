//
//  UserSearchDataStoring.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 02/03/2024.
//

import Foundation

protocol UserSearchResultsStoring {
    func getSearchResults() -> [UserModel]
    func saveSearchResults(_ users: [UserModel])
}
