import UIKit
import RxSwift

protocol IFavoritesPokemonsView: AnyObject
{
    var buttonShowPokedexHandler: (() -> Void)? { get set }
    func hideOrShowElement()
}

final class FavoritesPokemonsView: UIView, IFavoritesPokemonsView
{
    var buttonShowPokedexHandler: (() -> Void)?
    private let pokemonsTableView = UITableView()
    private let stubConteinerForElements = UIView()
    private lazy var stubButtonShowPokedex: UIButton = {
        let stubButtonShowPokedex = UIButton(type: .system)
        stubButtonShowPokedex.layer.cornerRadius = CGFloat(Layout.widthStabButton / 2)
        stubButtonShowPokedex.setTitle("Сhoose your Pokémons", for: .normal)
        stubButtonShowPokedex.backgroundColor = .darkGray
        stubButtonShowPokedex.tintColor = .white
        stubButtonShowPokedex.addTarget(self,
                                        action: #selector(stubButtonShowPokedexTapped),
                                        for: .touchUpInside)
        
        return stubButtonShowPokedex
    }()
    private let viewModel: IFavoritesPokemonsViewModel
    private let disposeBag = DisposeBag()
    private var pokemonArray: [PokemonEntryCoreData] = []
    
    init(viewModel: IFavoritesPokemonsViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.configure()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hideOrShowElement() {
        if self.pokemonArray.isEmpty {
            self.pokemonsTableView.isHidden = true
            self.stubConteinerForElements.isHidden = false
        } else {
            self.pokemonsTableView.isHidden = false
            self.stubConteinerForElements.isHidden = true
        }
    }
}

private extension FavoritesPokemonsView
{
    func configure() {
        self.configureTableView()
        self.buildUI()
    }
    
    func configureTableView() {
        self.pokemonsTableView.delegate = self
        self.pokemonsTableView.dataSource = self
        self.pokemonsTableView.register(FavoritesPokemonsTableViewCell.self,
                                forCellReuseIdentifier: "FavoritesPokemonsTableViewCell")
    }
    
    func buildUI() {
        self.addSubview(self.pokemonsTableView)
        self.pokemonsTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .inset(-Constants.Layout.verticalSpace)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        self.addSubview(self.stubConteinerForElements)
        self.stubConteinerForElements.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(Layout.widthStabConteiner)
            make.height.equalTo(Layout.heightStabConteiner)
        }
        
        self.stubConteinerForElements.addSubview(stubButtonShowPokedex)
        let stubImage = UIImageView()
        stubImage.contentMode = .scaleAspectFit
        stubImage.image = UIImage(named: "pikachu")
        self.stubConteinerForElements.addSubview(stubImage)
        stubImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(stubButtonShowPokedex.snp.top)
        }
        
        self.stubButtonShowPokedex.snp.makeConstraints { make in
            make.top.equalTo(stubImage.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(Layout.widthStabButton)
        }
    }
    
    func bind() {
        self.viewModel.pokemonArray.drive { [weak self] pokemons in
            self?.pokemonArray = pokemons
            self?.pokemonsTableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    func tableViewCellTapped(url: String) {
        self.viewModel.cellTapped(with: url)
    }
    
    func buttonLikeTapped(name: String?) {
        self.viewModel.deletePokemonFromDb(name: name ?? "")
        self.hideOrShowElement()
    }
    
    @objc func stubButtonShowPokedexTapped() {
        self.buttonShowPokedexHandler?()
    }
}

extension FavoritesPokemonsView: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.pokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = pokemonsTableView.dequeueReusableCell(
            withIdentifier: "FavoritesPokemonsTableViewCell",
            for: indexPath) as? FavoritesPokemonsTableViewCell else { return UITableViewCell() }
        
        let pokemon = self.pokemonArray[indexPath.row]
        
        let model = FavoritesPokemonCellModel(id: pokemon.id,
                                              dataImage: pokemon.image,
                                              pokemonType: pokemon.type,
                                              name: pokemon.name,
                                              genus: pokemon.genus)
        cell.configure(model: model)
        cell.buttonLikeHandler = { [weak self] in
            self?.buttonLikeTapped(name: pokemon.name)
        }
        
        return cell
    }
}

extension FavoritesPokemonsView: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = self.pokemonArray[indexPath.row]
        self.tableViewCellTapped(url: pokemon.url ?? "")
    
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Layout.heightTableViewCell
    }
}

fileprivate enum Layout
{
    static let heightTableViewCell: CGFloat = 150
    static let heightStabConteiner = 500
    static let widthStabConteiner = 250
    static let widthStabButton = 50
}
