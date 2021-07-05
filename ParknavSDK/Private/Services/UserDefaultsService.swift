//
//  UserDefaultsService.swift
//  ParknavSDK
//

import Foundation

class UserDefaultsService: NSObject, NSCoding {
    static let service = UserDefaultsService()
    private let sharedUserDefaults = UserDefaults.standard

    var userId: String?

    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        userId = aDecoder.decodeObject(forKey: "userId") as? String
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(userId, forKey: "userId")
    }

    func saveToUserDefaults() -> Bool {
        let archivedObject = try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
        sharedUserDefaults.set(archivedObject, forKey: "userDefaultsData")
        return sharedUserDefaults.synchronize()
    }

    func loadFromUserDefaults() -> Bool {
        var result: Bool = false
        if let decodedDataStub = sharedUserDefaults.object(forKey: "userDefaultsData") as? Data {
            if let savedUserData = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UserDefaultsService.self,
                                                                           from: decodedDataStub) {
                userId = savedUserData.userId
                result = true
            }
        }
        return result
    }

    func clearUserDefaults(saveHost: Bool) -> Bool {
        userId = nil
        return saveToUserDefaults()
    }
}
