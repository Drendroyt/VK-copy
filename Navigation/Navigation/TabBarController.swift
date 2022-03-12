//
//  TabBarController.swift
//  Navigation
//
//  Created by Кирилл Дамковский on 12.03.2022.
//

import UIKit

class TabBarController: UITabBarController {

    private enum TabBarItem {
        case feed
        case profile

        var title: String {
            switch self {
            case .feed:
                return "Лента"
            case .profile:
                return "Профиль"
            }
        }

        var image: UIImage? {
            switch self {
            case .feed:
                return UIImage(systemName: "house")
            case .profile:
                return UIImage(systemName: "person")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()

        // Do any additional setup after loading the view.
    }

    private func setupTabBar() {
        let items: [TabBarItem] = [.feed, .profile]
        self.viewControllers = items.map({ TabBarItem in
            switch TabBarItem {
            case .feed:
                return UINavigationController(rootViewController: FeedViewController())
            case .profile:
                return UINavigationController(rootViewController: ProfileViewController())
            }
        })

        self.viewControllers?.enumerated().forEach({ (index, vc) in
            vc.tabBarItem.title = items[index].title
            vc.tabBarItem.image = items[index].image
        })
    }

}

