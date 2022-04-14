//
//  TabBarController.swift
//  Diplom
//
//  Created by Мария Филиппова on 12.04.2022.
//
import UIKit

class TabBarController: UITabBarController{
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
                return UIImage(systemName: "paperplane")
            case .profile:
                return UIImage(systemName: "person.circle")
            }
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
    }
    
    
    func setupTabBar() {
        let items: [TabBarItem] = [.feed, .profile]
        
        self.viewControllers = items.map({ tabBarItem in
            switch tabBarItem {
            case .feed:
                return UINavigationController(rootViewController: FeedViewController())
            case .profile:
                return UINavigationController(rootViewController: LogInViewController())
            }
        })
        
        self.viewControllers?.enumerated().forEach({ (index, vc) in
            vc.tabBarItem.title = items[index].title
            vc.tabBarItem.image = items[index].image
        })
    }
}
