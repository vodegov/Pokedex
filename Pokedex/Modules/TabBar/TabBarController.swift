import UIKit

final class TabBarController: UITabBarController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        tabBar.backgroundColor = Constants.Colors.background
        tabBar.tintColor = Constants.Colors.defaulText
        
        let allPokemonsViewModel = AllPokemonsViewModel()
        let allPokemonRouter = AllPokemonsRouter()
        let allPokemonViewController = AllPokemonsViewController(viewModel: allPokemonsViewModel, router: allPokemonRouter)
        allPokemonRouter.viewController = allPokemonViewController
        
        let allPokemonsViewController = createNavController(
            vc: allPokemonViewController,
            itemName: "Pokemon",
            itemImage: UIImage(named: "pokeball") ?? UIImage()
        )
        
        let favoritesPokemonsViewModel = FavoritesPokemonsViewModel()
        let favoritesPokemonRouter = FavoritesPokemonsRouter()
        let favoritesPokemonViewController = FavoritesPokemonsViewController(viewModel: favoritesPokemonsViewModel, router: favoritesPokemonRouter)
        favoritesPokemonRouter.viewController = favoritesPokemonViewController
        
        let favoritesPokemonsViewController = createNavController(
            vc: favoritesPokemonViewController,
            itemName: "Favorites",
            itemImage: UIImage(systemName: "heart.fill") ?? UIImage()
        )
        
        viewControllers = [allPokemonsViewController, favoritesPokemonsViewController]
    }
    
    func createNavController(vc: UIViewController, itemName: String, itemImage: UIImage) -> UINavigationController {
        
        let item = UITabBarItem(title: .none, image: itemImage
            .withAlignmentRectInsets(
                .init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 5)
        
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        
        return navController
    }
    
}

