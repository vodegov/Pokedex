
import UIKit
import RxSwift

final class DetailPokemonsView: UIView
{
    // MARK: - var/let
    private let backButton = UIButton(type: .system)
    private let likeButton = UIButton(type: .system)
    private var headerView = UIView()
    private let imageViewPokemon = UIImageView()
    private let detailPokemonTableView = ParalaxTableView()
    private let viewModel: IDetailPokemonsViewModel
    private let disposeBag = DisposeBag()
    private var pokemonDetail: Pokemon?
    private var pokemonEvolutionImages: [String: Data]?
    private let pokemonMaper = PokemonMaper()
    private var segmentControllIndex = Int()
    
    init(viewModel: IDetailPokemonsViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.configure()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension DetailPokemonsView
{
    func configure() {
        self.backgroundColor = .black
        self.configureTableView()
        self.buildUI()
    }
    
    func buildUI() {
        self.addSubview(detailPokemonTableView)
        self.detailPokemonTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
//        self.addSubview(backButton)
//        self.backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
//        self.backButton.tintColor = .white
//        self.backButton.snp.makeConstraints { make in
//            make.top.equalTo(safeAreaLayoutGuide)
//                .inset(Constants.Layout.verticalSpace)
//            make.leading.equalToSuperview()
//                .inset(Constants.Layout.horizontalSpace)
//        }
//        
//        self.addSubview(likeButton)
//        self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
//        self.likeButton.tintColor = .white
//        self.likeButton.snp.makeConstraints { make in
//            make.top.equalTo(self.backButton)
//            make.trailing.equalToSuperview()
//                .inset(Constants.Layout.horizontalSpace)
//        }
        
        headerView = UIView(frame: CGRect(x: 0, y: 0, width:self.detailPokemonTableView.frame.width, height: 450))
        headerView.addSubview(imageViewPokemon)
        imageViewPokemon.contentMode = .scaleAspectFill
        imageViewPokemon.snp.makeConstraints { make in
            make.bottom.equalToSuperview().labeled("bottom")
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(headerView.frame.height).labeled("height")
        }
        self.detailPokemonTableView.tableHeaderView = headerView  
    }
    
    func configureTableView() {
        self.detailPokemonTableView.delegate = self
        self.detailPokemonTableView.dataSource = self
        self.detailPokemonTableView.separatorStyle = .none
        self.detailPokemonTableView.showsVerticalScrollIndicator = false
        self.detailPokemonTableView.register(NameAndTypeOfPokemonTableViewCell.self,
                                             forCellReuseIdentifier: "NameAndTypeOfPokemonTableViewCell")
        self.detailPokemonTableView.register(SegmentControlTableViewCell.self,
                                             forCellReuseIdentifier: "SegmentControlTableViewCell")
        self.detailPokemonTableView.register(AboutViewTableViewCell.self,
                                             forCellReuseIdentifier: "AboutViewTableViewCell")
        self.detailPokemonTableView.register(StatsTableViewCell.self,
                                             forCellReuseIdentifier: "StatsTableViewCell")
        self.detailPokemonTableView.register(MovesTableViewCell.self,
                                             forCellReuseIdentifier: "MovesTableViewCell")
        self.detailPokemonTableView.register(EvolutionTableViewCell.self,
                                             forCellReuseIdentifier: "EvolutionTableViewCell")
    }
    
    func bind() {
        self.viewModel.pokemonDetail.drive { [weak self] pokemon in
            self?.pokemonDetail = pokemon
            self?.setBackgraundImage()
            self?.setImagePokemon(dataImage: pokemon.image ?? Data())
            self?.detailPokemonTableView.reloadData()
        }.disposed(by: disposeBag)
        
        self.viewModel.pokemonEvolutionImages.drive { [weak self] images in
            self?.pokemonEvolutionImages = images
        }.disposed(by: disposeBag)
    }
    
    func setBackgraundImage() {
        let imageName = self.pokemonMaper.getPokemonType(model: self.pokemonDetail ?? Pokemon.emptyPokemon)
        self.detailPokemonTableView.backgroundView = UIImageView(image: UIImage(named: imageName))
    }
    
    func setImagePokemon(dataImage: Data) {
        imageViewPokemon.image = UIImage(data: dataImage)
    }
    
    func segmentControllChanged(index: Int) {
        self.segmentControllIndex = index
        self.detailPokemonTableView.reloadData()
    }
    
    func findColorFromType() -> UIColor {
        let typePokemon = self.pokemonMaper.getPokemonType(model: pokemonDetail ?? Pokemon.emptyPokemon)
        switch typePokemon {
        case "bug", "grass":
            return #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5960784314, alpha: 1)
        case "fire":
            return #colorLiteral(red: 1, green: 0.7098039216, blue: 0.3215686275, alpha: 1)
        case "water", "ice":
            return #colorLiteral(red: 0.2941176471, green: 0.5960784314, blue: 0.7725490196, alpha: 1)
        case "electric", "dragon":
            return #colorLiteral(red: 1, green: 0.9495328098, blue: 0.1884809652, alpha: 1)
        case "poison", "ghost", "psychic":
            return #colorLiteral(red: 0.631372549, green: 0.5450980392, blue: 0.862745098, alpha: 1)
        case "normal", "fighting":
            return #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        case "fairy":
            return #colorLiteral(red: 0.9607843137, green: 0.6745098039, blue: 0.737254902, alpha: 1)
            
        default:
            return #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        }
    }
}

extension DetailPokemonsView: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = detailPokemonTableView.dequeueReusableCell(
                withIdentifier: "NameAndTypeOfPokemonTableViewCell",
                for: indexPath) as? NameAndTypeOfPokemonTableViewCell else { return UITableViewCell() }
            
            guard let name = self.pokemonDetail?.name else { return cell }
            let genus = self.pokemonMaper.getPokemonGenus(model: self.pokemonDetail ?? Pokemon.emptyPokemon) ?? ""
            
            cell.configure(name: name.capitalized, genus: genus, model: pokemonDetail?.types ?? [])
            
            return cell
        case 1:
            guard let cell = detailPokemonTableView.dequeueReusableCell(
                withIdentifier: "SegmentControlTableViewCell",
                for: indexPath) as? SegmentControlTableViewCell else { return UITableViewCell() }
            cell.segmentControllHandler = { [weak self] index in
                self?.segmentControllChanged(index: index)
            }
            
            return cell
        case 2:
            switch self.segmentControllIndex {
            case Constants.SegmentControllIndex.About.rawValue:
                guard let cell = detailPokemonTableView.dequeueReusableCell(
                    withIdentifier: "AboutViewTableViewCell",
                    for: indexPath) as? AboutViewTableViewCell else { return UITableViewCell() }
                let aboutText = self.pokemonMaper.getPokemonAboutText(model: self.pokemonDetail ?? Pokemon.emptyPokemon) ?? ""
                let replacingAboutText = aboutText.replacingOccurrences(of: "\n", with: " ")
                cell.configure(about: (replacingAboutText), weight: pokemonDetail?.weight ?? 0, height: pokemonDetail?.height ?? 0, experience: pokemonDetail?.base_experience ?? 0)
                return cell
                
            case Constants.SegmentControllIndex.Stats.rawValue:
                guard let cell = detailPokemonTableView.dequeueReusableCell(
                    withIdentifier: "StatsTableViewCell",
                    for: indexPath) as? StatsTableViewCell else { return UITableViewCell() }
                
                let hpStat = pokemonMaper.getPokemonHp(model: pokemonDetail ?? Pokemon.emptyPokemon) ?? 0
                let attackStat = pokemonMaper.getPokemonAttack(model: pokemonDetail ?? Pokemon.emptyPokemon) ?? 0
                let defenseStat = pokemonMaper.getPokemonDefense(model: pokemonDetail ?? Pokemon.emptyPokemon) ?? 0
                let specialAttackStat = pokemonMaper.getPokemonSpecialAttack(model: pokemonDetail ?? Pokemon.emptyPokemon) ?? 0
                let specialDefenseStat = pokemonMaper.getPokemonSpecialDefense(model: pokemonDetail ?? Pokemon.emptyPokemon) ?? 0
                let speedStat = pokemonMaper.getPokemonSpeed(model: pokemonDetail ?? Pokemon.emptyPokemon) ?? 0
                
                cell.configure(hp: hpStat,
                               attack: attackStat,
                               defense: defenseStat,
                               specialAttack: specialAttackStat,
                               specialDefense: specialDefenseStat,
                               speed: speedStat, color: findColorFromType())
                return cell
                
            case Constants.SegmentControllIndex.Moves.rawValue:
                guard let cell = detailPokemonTableView.dequeueReusableCell(
                    withIdentifier: "MovesTableViewCell",
                    for: indexPath) as? MovesTableViewCell else { return UITableViewCell() }
                cell.setupMovesData(model: self.pokemonDetail?.moves ?? [])
                return cell
                
            case Constants.SegmentControllIndex.Evolutions.rawValue:
                guard let cell = detailPokemonTableView.dequeueReusableCell(
                    withIdentifier: "EvolutionTableViewCell",
                    for: indexPath) as? EvolutionTableViewCell else { return UITableViewCell() }
                
                let firstStepName = pokemonDetail?.evolution?.chain?.species.name ?? ""
                let secondStepName = pokemonDetail?.evolution?.chain?.evolves_to?.first?.species.name
                let thirdStepName = pokemonDetail?.evolution?.chain?.evolves_to?.first?.evolves_to?.first?.species.name
                let levelFirst = pokemonDetail?.evolution?.chain?.evolves_to?.first?.evolution_details?.first?.min_level ?? 0
                let levelSecond = pokemonDetail?.evolution?.chain?.evolves_to?.first?.evolves_to?.first?.evolution_details?.first?.min_level ?? 0
                
                cell.configure(nameFirstStep: firstStepName,
                               nameSecondStep: secondStepName,
                               nameThirdStep: thirdStepName,
                               idFirstStep: pokemonDetail?.evolution?.id ?? 0,
                               levelFirstText: levelFirst,
                               levelSecondText: levelSecond,
                               firsdDataImage: self.pokemonEvolutionImages?[firstStepName] ?? Data(),
                               secondDataImage: self.pokemonEvolutionImages?[secondStepName ?? ""] ?? Data(),
                               thirdDataImage: self.pokemonEvolutionImages?[thirdStepName ?? ""] ?? Data())
                
                
                return cell
            default:
                return UITableViewCell()
            }
            
            
        default: return UITableViewCell()
        }
        
    }
    
    
}

extension DetailPokemonsView: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 110
        case 1: return 50
        case 2: return UITableView.automaticDimension
        default: return 0
        }
    }
}


