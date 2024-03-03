//
//  UserSearchScreenViewModel.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 03/03/2024.
//

import Foundation
import Combine

@MainActor
final class UserSearchScreenViewModel: ObservableObject {
    // MARK: - DI
    private let userRepository: UserSearchRepository
    // MARK: - Variables
    @Published var users: [UserModel] = []
    @Published var searchQuery: String = ""
    private var searchTask: Task<()?,Never>? = nil
    private var cancelBag = Set<AnyCancellable>()
    
    init(userRepository: UserSearchRepository) {
        self.userRepository = userRepository
        observeSearchQuery()
    }
    
    func observeSearchQuery() {
        $searchQuery
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .throttle(for: 0.5, scheduler: RunLoop.main, latest: true)
            .filter{ !$0.isEmpty }
            .sink { [weak self] query in
                self?.searchTask?.cancel()
                self?.searchTask = Task {
                    await self?.searchUsers(by: query)
                }
            }
            .store(in: &cancelBag)
    }
    
    func searchUsers(by query: String) async {
        print("Searching for: \(searchQuery)")
        users = await userRepository.fetchUsers(by: query)
    }
}
