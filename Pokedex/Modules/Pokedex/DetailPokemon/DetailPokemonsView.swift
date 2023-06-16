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

// MARK: - private extension
private extension DetailPokemonsView
{
    func configure() {
        self.configureTableView()
        self.buildUI()
    }
    
    func buildUI() {
        self.addSubview(detailPokemonTableView)
        self.detailPokemonTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
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
        self.detailPokemonTableView.register(AboutTableViewCell.self,
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
            self?.setImagePokemon(dataImage: pokemon.image)
            self?.detailPokemonTableView.reloadData()
        }.disposed(by: disposeBag)
        
        self.viewModel.pokemonEvolutionImages.drive { [weak self] images in
            self?.pokemonEvolutionImages = images
        }.disposed(by: disposeBag)
    }
    
    func setBackgraundImage() {
        let imageName = self.pokemonMaper.getPokemonType(model: self.pokemonDetail)
        self.detailPokemonTableView.backgroundView = UIImageView(image: UIImage(named: imageName))
    }
    
    func setImagePokemon(dataImage: Data?) {
        if let dataImage = dataImage {
            imageViewPokemon.image = UIImage(data: dataImage)
        } else {
            imageViewPokemon.image = UIImage(named: "emptyPokemon")
        }
    }
    
    func segmentControllChanged(index: Int) {
        self.segmentControllIndex = index
        self.detailPokemonTableView.reloadData()
    }
}

// MARK: - Configure cells
private extension DetailPokemonsView
{
    func configureNameTableViewCell(with indexPath: IndexPath) -> UITableViewCell {
        guard let cell = detailPokemonTableView.dequeueReusableCell(
            withIdentifier: "NameAndTypeOfPokemonTableViewCell",
            for: indexPath) as? NameAndTypeOfPokemonTableViewCell else { return UITableViewCell() }
        
        guard let name = self.pokemonDetail?.name else { return cell }
        let genus = self.pokemonMaper.getPokemonGenus(model: self.pokemonDetail)
        
        let model = NameCellModel(name: name,
                                  genus: genus,
                                  modelType: pokemonDetail?.types)
        
        cell.configure(model: model)
        
        return cell
    }
    
    func configureSegmentTableViewCell(with indexPath: IndexPath) -> UITableViewCell {
        guard let cell = detailPokemonTableView.dequeueReusableCell(
            withIdentifier: "SegmentControlTableViewCell",
            for: indexPath) as? SegmentControlTableViewCell else { return UITableViewCell() }
        cell.segmentControllHandler = { [weak self] index in
            self?.segmentControllChanged(index: index)
        }
        
        return cell
    }
    
    func configureAboutTableViewCell(with indexPath: IndexPath) -> UITableViewCell {
        guard let cell = detailPokemonTableView.dequeueReusableCell(
            withIdentifier: "AboutViewTableViewCell",
            for: indexPath) as? AboutTableViewCell else { return UITableViewCell() }
        let aboutText = self.pokemonMaper.getPokemonAboutText(model: self.pokemonDetail)
        let replacingAboutText = aboutText?.replacingOccurrences(of: "\n", with: " ")
        let model = AboutCellModel(about: replacingAboutText,
                                   weight: self.pokemonDetail?.weight,
                                   height: self.pokemonDetail?.height,
                                   experience: self.pokemonDetail?.base_experience,
                                   catchRate: self.pokemonDetail?.aboutPokemon?.capture_rate)
        cell.configure(model: model)
        return cell
    }
    
    func configureStatsTableViewCell(with indexPath: IndexPath) -> UITableViewCell {
        guard let cell = detailPokemonTableView.dequeueReusableCell(
            withIdentifier: "StatsTableViewCell",
            for: indexPath) as? StatsTableViewCell else { return UITableViewCell() }
        
        let hpStat = pokemonMaper.getPokemonHp(model: pokemonDetail)
        let attackStat = pokemonMaper.getPokemonAttack(model: pokemonDetail)
        let defenseStat = pokemonMaper.getPokemonDefense(model: pokemonDetail)
        let specialAttackStat = pokemonMaper.getPokemonSpecialAttack(model: pokemonDetail)
        let specialDefenseStat = pokemonMaper.getPokemonSpecialDefense(model: pokemonDetail)
        let speedStat = pokemonMaper.getPokemonSpeed(model: pokemonDetail)
        
        let model = StatsCellModel(hp: hpStat,
                                   attack: attackStat,
                                   defense: defenseStat,
                                   specialAttack: specialAttackStat,
                                   specialDefense: specialDefenseStat,
                                   speed: speedStat,
                                   color: findColorFromType())
        
        cell.configure(model: model)
        return cell
    }
    
    func configureMovesTableViewCell(with indexPath: IndexPath) -> UITableViewCell {
        guard let cell = detailPokemonTableView.dequeueReusableCell(
            withIdentifier: "MovesTableViewCell",
            for: indexPath) as? MovesTableViewCell else { return UITableViewCell() }
        cell.setupMovesData(model: self.pokemonDetail?.moves ?? [])
        return cell
    }
    
    func configureEvolutionTableViewCell(with indexPath: IndexPath) -> UITableViewCell {
        guard let cell = detailPokemonTableView.dequeueReusableCell(
            withIdentifier: "EvolutionTableViewCell",
            for: indexPath) as? EvolutionTableViewCell else { return UITableViewCell() }
        
        let firstStepName = pokemonDetail?.evolution?.chain?.species.name ?? ""
        let secondStepName = pokemonDetail?.evolution?.chain?.evolves_to?.first?.species.name ?? ""
        let thirdStepName = pokemonDetail?.evolution?.chain?.evolves_to?.first?.evolves_to?.first?.species.name ?? ""
        let levelFirst = pokemonDetail?.evolution?.chain?.evolves_to?.first?.evolution_details?.first?.min_level ?? 0
        let levelSecond = pokemonDetail?.evolution?.chain?.evolves_to?.first?.evolves_to?.first?.evolution_details?.first?.min_level ?? 0
        
        let model = EvolutionCellModel(nameFirstStep: firstStepName,
                                       nameSecondStep: secondStepName,
                                       nameThirdStep: thirdStepName,
                                       idFirstStep: pokemonDetail?.evolution?.id ?? 0,
                                       idSecondStep: 0,
                                       idThirdStep: 0,
                                       levelFirstText: levelFirst,
                                       levelSecondText: levelSecond,
                                       firsdDataImage: self.pokemonEvolutionImages?[firstStepName],
                                       secondDataImage: self.pokemonEvolutionImages?[secondStepName],
                                       thirdDataImage: self.pokemonEvolutionImages?[thirdStepName])
        cell.configure(model: model)

        return cell
    }
}

// MARK: - UITableViewDataSource
extension DetailPokemonsView: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return configureNameTableViewCell(with: indexPath)
        case 1:
            return configureSegmentTableViewCell(with: indexPath)
        case 2:
            switch self.segmentControllIndex {
            case Constants.SegmentControllIndex.About.rawValue:
                return configureAboutTableViewCell(with: indexPath)
            case Constants.SegmentControllIndex.Stats.rawValue:
                return configureStatsTableViewCell(with: indexPath)
            case Constants.SegmentControllIndex.Moves.rawValue:
                return configureMovesTableViewCell(with: indexPath)
            case Constants.SegmentControllIndex.Evolutions.rawValue:
                return configureEvolutionTableViewCell(with: indexPath)
            default:
                return UITableViewCell()
            }
        default: return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
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

// MARK: - Configure color of type
extension DetailPokemonsView
{
    func findColorFromType() -> UIColor {
        let typePokemon = self.pokemonMaper.getPokemonType(model: pokemonDetail)
        
        switch typePokemon {
        case PokemonType.bug.rawValue, PokemonType.grass.rawValue:
            return PokemonType.bug.color
        case PokemonType.fire.rawValue:
            return PokemonType.fire.color
        case PokemonType.water.rawValue, PokemonType.ice.rawValue:
            return PokemonType.water.color
        case PokemonType.electric.rawValue, PokemonType.dragon.rawValue:
            return PokemonType.electric.color
        case PokemonType.poison.rawValue, PokemonType.ghost.rawValue, PokemonType.psychic.rawValue:
            return PokemonType.poison.color
        case PokemonType.normal.rawValue, PokemonType.fighting.rawValue:
            return PokemonType.normal.color
        case PokemonType.fairy.rawValue:
            return PokemonType.fairy.color
        default:
            return PokemonType.other.color
        }
    }
}

enum PokemonType: String {
    case bug = "bug"
    case grass = "grass"
    case fire = "fire"
    case water = "water"
    case ice = "ice"
    case electric = "electric"
    case dragon = "dragon"
    case poison = "poison"
    case ghost = "ghost"
    case psychic = "psychic"
    case normal = "normal"
    case fighting = "fighting"
    case fairy = "fairy"
    case other = "other"
    
    var color: UIColor {
        switch self {
            
        case .bug, .grass:
            return #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5960784314, alpha: 1)
        case .fire:
            return #colorLiteral(red: 1, green: 0.7098039216, blue: 0.3215686275, alpha: 1)
        case .water, .ice:
            return #colorLiteral(red: 0.2941176471, green: 0.5960784314, blue: 0.7725490196, alpha: 1)
        case .electric, .dragon:
            return #colorLiteral(red: 1, green: 0.9495328098, blue: 0.1884809652, alpha: 1)
        case .poison, .ghost, .psychic:
            return #colorLiteral(red: 0.631372549, green: 0.5450980392, blue: 0.862745098, alpha: 1)
        case .normal, .fighting:
            return #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        case .fairy:
            return #colorLiteral(red: 0.9607843137, green: 0.6745098039, blue: 0.737254902, alpha: 1)
        case .other:
            return #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }
    }
}
