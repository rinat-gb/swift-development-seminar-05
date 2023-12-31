//
//  ProfileModel.swift
//  NetworkVisualAnimation
//
//  Created by Ринат on 29.08.2023.
//

struct ProfileModel: Decodable {
    var response: Profile

    struct Profile: Decodable {
        var firstName: String?
        var lastName: String?
        var screenName: String?
        var photo: String?

        enum CodingKeys: String, CodingKey {
            case firstName = "first_name"
            case lastName = "last_name"
            case screenName = "screen_name"
            case photo = "photo_200"
        }
    }
}
