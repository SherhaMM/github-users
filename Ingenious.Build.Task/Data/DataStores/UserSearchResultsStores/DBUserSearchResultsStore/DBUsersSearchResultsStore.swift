//
//  UsersDataStore.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 02/03/2024.
//

import Foundation
import SwiftData

final class DBUserSearchResultsStore: UserSearchResultsStoring {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func getSearchResults() -> [UserModel] {
        let result = try? modelContext.fetch(FetchDescriptor<UserModelObject>())
        // Errors handling is out of scope for this task
        return result?.map { $0.toModel } ?? []
    }
    
    func saveSearchResults(_ users: [UserModel]) {
        let objs = users.map { UserModelObject(from: $0) }
        try? modelContext.transaction {
            for obj in objs {
                modelContext.insert(obj)
            }
            
            try? modelContext.save()
        }
    }
    
    func getSearchSuggestions() -> [String] {
        let results = try? modelContext.fetch(FetchDescriptor<SearchSuggestionObject>())
        // Errors handling is out of scope for this task
        return results?.map { $0.searchString } ?? []
    }
    
    func saveSearchSuggestion(_ searchTerm: String) {
        let obj = SearchSuggestionObject(searchString: searchTerm)
        modelContext.insert(obj)
    }
}
