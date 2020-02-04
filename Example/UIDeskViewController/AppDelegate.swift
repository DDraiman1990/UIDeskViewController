//
//  AppDelegate.swift
//  UIDeskViewController
//
//  Created by ddraiman1990 on 02/04/2020.
//  Copyright © 2020 Nexxmark Studio.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    public var users: [SimpleUser] = []
    
    lazy var  coreDataStack = CoreDataStack(modelName: "UIDeskViewController")
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        importJSONSeedData()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        coreDataStack.saveContext()
    }
}

// MARK: - Helper methods
extension AppDelegate {
    func saveJSONToCoreDataIfNeeded(users: [SimpleUser]) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        guard let count = try? coreDataStack.managedContext.count(for: fetchRequest),
          count == 0 else {
            print("There are already users in CoreData")
            return
        }
        for simpleUser in users {
          let user = User(context: coreDataStack.managedContext)
            user.firstname = simpleUser.firstname
            user.lastname = simpleUser.lastname
            user.age = Int16(simpleUser.age)
        }
        print("Imported \(users.count) users to CoreData")
        coreDataStack.saveContext()
    }

  func importJSONSeedData() {
    let jsonURL = Bundle.main.url(forResource: "seed", withExtension: "json")!
    let jsonData = try! Data(contentsOf: jsonURL)

    do {
      let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: [.allowFragments]) as! [[String: Any]]

        let users = jsonArray.map { jsonDictionary -> SimpleUser in
            let firstname = jsonDictionary["firstname"] as! String
            let lastname = jsonDictionary["lastname"] as! String
            let age = jsonDictionary["age"] as! Int
            return SimpleUser(firstname: firstname,
                              lastname: lastname,
                              age: age)
        }
        self.users = users
        saveJSONToCoreDataIfNeeded(users: users)
        print("Imported \(jsonArray.count) users")
    } catch let error as NSError {
        print("Error importing users: \(error)")
    }
  }
}


