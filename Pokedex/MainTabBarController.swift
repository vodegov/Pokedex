import UIKit

final class MainTabBarController: UITabBarController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        
        tabBar.backgroundColor = .darkGray
        tabBar.tintColor = .black
        
        let allPokemonsViewController = createNavController(
            vc: AllPokemonsViewController(),
            itemName: "Pokemon",
            itemImage: UIImage(named: "pokeball") ?? UIImage()
        )
        
        let favoritesPokemonsViewController = createNavController(
            vc: FavoritesPokemonsViewController(),
            itemName: "Favorites",
            itemImage: UIImage(systemName: "heart.fill") ?? UIImage()
        )
        
        viewControllers = [
            allPokemonsViewController,
            favoritesPokemonsViewController,
        ]
    }
    
    func createNavController(vc: UIViewController, itemName: String, itemImage: UIImage) -> UINavigationController {
        
        let item = UITabBarItem(title: itemName, image: itemImage
                .withAlignmentRectInsets(
                    .init(top: 10,
                          left: 0,
                          bottom: 0,
                          right: 0
                         )
                ),
            tag: 0
        )
        
        item.titlePositionAdjustment = .init(
            horizontal: 0,
            vertical: 5
        )
        
        let navController = UINavigationController(
            rootViewController: vc
        )
        navController.tabBarItem = item
        
        return navController
    }

}

