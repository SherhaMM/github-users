//
//  SearchSuggestionObject.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 02/03/2024.
//

import Foundation
import SwiftData

@Model
final class SearchSuggestionObject {
    let searchString: String
    
    init(searchString: String) {
        self.searchString = searchString
    }
}
