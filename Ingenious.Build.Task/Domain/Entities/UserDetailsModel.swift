//
//  UserDetailsModel.swift
//  Ingenious.Build.Task
//
//  Created by Makcim Mikhailov on 02/03/2024.
//

import Foundation

struct UserDetailsModel: Codable {
    let id: Int
    let login: String
    let avatarUrl: String
    let name: String?
    let company: String?
    let bio: String?
    
    enum CodingKeys: String, CodingKey {
        case id, login, name, company, bio
        case avatarUrl = "avatar_url"
    }
    
    init(id: Int, login: String, avatarUrl: String, name: String?, company: String?, bio: String?) {
        self.id = id
        self.login = login
        self.avatarUrl = avatarUrl
        self.name = name
        self.company = company
        self.bio = bio
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.login = try container.decode(String.self, forKey: .login)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.company = try container.decodeIfPresent(String.self, forKey: .company)
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio)
        self.avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
    }
}
