import UIKit
import RxSwift

final class AllPokemonsView: UIView
{
    // MARK: - var/let
    private let pokemonTableView = UITableView()
    private let searchBar = UISearchBar()
    private let viewModel: IAllPokemonsViewModel
    private let disposeBag = DisposeBag()
    private var pokemonArray: [PokemonEntry] = []
    
    init(viewModel: IAllPokemonsViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.configure()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - private extension
private extension AllPokemonsView
{
    func configure() {
        configureTableView()
        buildUI()
        self.searchBar.delegate = self
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    func configureTableView() {
        self.pokemonTableView.delegate = self
        self.pokemonTableView.dataSource = self
        self.pokemonTableView.register(AllPokemonsTableViewCell.self,
                                forCellReuseIdentifier: "AllPokemonsTableViewCell")
    }
    
    func buildUI() {
        self.addSubview(self.searchBar)
        self.searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
                .inset(Constants.Layout.horizontalSpace)
        }
        
        self.addSubview(pokemonTableView)
        pokemonTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
                .inset(-Constants.Layout.verticalSpace)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func tableViewCellTapped(url: String) {
        self.viewModel.cellTapped(with: url)
    }
    
    func bind() {
        self.viewModel.pokemonArray.drive { [weak self] pokemons in
            self?.pokemonArray = pokemons
            self?.pokemonTableView.reloadData()
        }.disposed(by: disposeBag)
        
        self.viewModel.pokemonSearch.drive { [weak self] url in
            self?.tableViewCellTapped(url: url)
        }.disposed(by: disposeBag)
    }
    
    @objc func searchButtonTapped() {
        let pokemonName = self.searchBar.searchTextField.text?.lowercased() ?? ""
        self.viewModel.getSearchPokemon(name: pokemonName)
        self.dismissKeyboard()
    }
    
    @objc func dismissKeyboard() {
        self.searchBar.resignFirstResponder()
    }
}

// MARK: - UITableViewDataSource
extension AllPokemonsView: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.pokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = pokemonTableView.dequeueReusableCell(
            withIdentifier: "AllPokemonsTableViewCell",
            for: indexPath) as? AllPokemonsTableViewCell else { return UITableViewCell() }
        let pokemon = self.pokemonArray[indexPath.row]
        
        let urlImage = Constants.URLs.pokemonImagePreview + "\(indexPath.row + 1).png"
        let id = indexPath.row + 1
        
        let model = AllPokemonsCellModel(id: id, name: pokemon.name.capitalized, url: urlImage)
        cell.configure(model: model)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AllPokemonsView: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = self.pokemonArray[indexPath.row]
        self.tableViewCellTapped(url: pokemon.url)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Layout.heightTableViewCell
    }
}

// MARK: - UISearchBarDelegate
extension AllPokemonsView: UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchButtonTapped()
    }
}

fileprivate enum Layout
{
    static let heightTableViewCell: CGFloat = 100
}
