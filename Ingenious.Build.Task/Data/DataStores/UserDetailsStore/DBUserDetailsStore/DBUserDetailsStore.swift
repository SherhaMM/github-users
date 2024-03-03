//
//  DBUserDetailsStore.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 02/03/2024.
//

import Foundation
import SwiftData

final class DBUserDetailsStore: UserDetailsStoring {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func saveUser(_ user: UserDetailsModel) {
        let obj = UserDetailsObject(from: user)
        modelContext.insert(obj)
    }
    
    func getUser(by login: String) -> UserDetailsModel? {
        let predicate = #Predicate<UserDetailsObject> { obj in
            obj.login == login
        }
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1
        let result = try? modelContext.fetch(descriptor)
        return result?.first?.toModel
    }
}
