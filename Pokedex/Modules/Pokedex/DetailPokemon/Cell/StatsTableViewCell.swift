import UIKit

final class StatsTableViewCell: UITableViewCell
{
    private lazy var nameStatsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        
        return stackView
    }()
    private lazy var statsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        
        return stackView
    }()
    private lazy var marksStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        
        return stackView
    }()
    private lazy var hpLabel: UILabel = {
        let hplabel = UILabel()
        hplabel.textColor = .white
        hplabel.font = Constants.Fonts.aboutPokemonText
        hplabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        hplabel.textAlignment = .right
        
        return hplabel
    }()
    private lazy var hpMarkStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        
        return stackView
    }()
    private lazy var attackLabel: UILabel = {
        let atackLabel = UILabel()
        atackLabel.textColor = .white
        atackLabel.font = Constants.Fonts.aboutPokemonText
        atackLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        atackLabel.textAlignment = .right
        
        return atackLabel
    }()
    private lazy var attackMarkStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        
        return stackView
    }()
    private lazy var defenseLabel: UILabel = {
        let defenceLabel = UILabel()
        defenceLabel.textColor = .white
        defenceLabel.font = Constants.Fonts.aboutPokemonText
        defenceLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        defenceLabel.textAlignment = .right
        
        return defenceLabel
    }()
    private lazy var defenseMarkStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        
        return stackView
    }()
    private lazy var specialAttackLabel: UILabel = {
        let specialAtackLabel = UILabel()
        specialAtackLabel.textColor = .white
        specialAtackLabel.font = Constants.Fonts.aboutPokemonText
        specialAtackLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        specialAtackLabel.textAlignment = .right
        
        return specialAtackLabel
    }()
    private lazy var specialAttackMarkStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        
        return stackView
    }()
    private lazy var specialDefenseLabel: UILabel = {
        let specialDefenceLabel = UILabel()
        specialDefenceLabel.textColor = .white
        specialDefenceLabel.font = Constants.Fonts.aboutPokemonText
        specialDefenceLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        specialDefenceLabel.textAlignment = .right
        
        return specialDefenceLabel
    }()
    private lazy var specialDefenseMarkStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        
        return stackView
    }()
    private lazy var speedLabel: UILabel = {
        let speedLabel = UILabel()
        speedLabel.textColor = .white
        speedLabel.font = Constants.Fonts.aboutPokemonText
        speedLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        speedLabel.textAlignment = .right
        
        return speedLabel
    }()
    private lazy var speedMarkStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        
        return stackView
    }()
    private let descriptiontText = "The ranges shown on the right are for a level 100 Pokémon. Maximum values are based on a beneficial nature, 252 EVs, 31 IVs; minimum values are based on a hindering nature, 0 EVs, 0 IVs."
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StatsTableViewCell: ITableViewCell
{
    typealias Model = StatsCellModel
    
    func configure(model: StatsCellModel) {
        self.hpLabel.text = "\(model.hp)"
        self.createArrayView(mark: model.hp,
                             color: model.color,
                             stackView: hpMarkStackView)
        
        self.attackLabel.text = "\(model.attack)"
        self.createArrayView(mark: model.attack,
                             color: model.color,
                             stackView: attackMarkStackView)
        
        self.defenseLabel.text = "\(model.defense)"
        self.createArrayView(mark: model.defense,
                             color: model.color,
                             stackView: defenseMarkStackView)
        
        self.specialAttackLabel.text = "\(model.specialAttack)"
        self.createArrayView(mark: model.specialAttack,
                             color: model.color,
                             stackView: specialAttackMarkStackView)
        
        self.specialDefenseLabel.text = "\(model.specialDefense)"
        self.createArrayView(mark: model.specialDefense,
                             color: model.color,
                             stackView: specialDefenseMarkStackView)
        
        self.speedLabel.text = "\(model.speed)"
        self.createArrayView(mark: model.speed,
                             color: model.color,
                             stackView: speedMarkStackView)
    }
}

private extension StatsTableViewCell
{
    func buildUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.contentView.addSubview(self.nameStatsStackView)
        self.nameStatsStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
                .inset(Constants.Layout.horizontalSpace)
            make.top.equalToSuperview()
                .inset(Layout.verticalSpace)
        }
        
        self.addElementsToNameStatsStackView()
        
        self.contentView.addSubview(self.statsStackView)
        self.statsStackView.snp.makeConstraints { make in
            make.leading.equalTo(self.nameStatsStackView.snp.trailing)
                .inset(-Constants.Layout.horizontalSpace)
            make.top.equalTo(self.nameStatsStackView)
        }
        
        self.addElementsToStatsStackView()
        
        self.contentView.addSubview(marksStackView)
        self.marksStackView.snp.makeConstraints { make in
            make.top.equalTo(self.nameStatsStackView)
            make.leading.equalTo(self.statsStackView.snp.trailing)
                .inset(-Constants.Layout.horizontalSpace)
            make.trailing.equalToSuperview()
                .inset(Constants.Layout.horizontalSpace)
        }

        self.addElementsToMarksStackView()
        
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = Constants.Colors.aboutPokemonText
        descriptionLabel.font = Constants.Fonts.descriptionStatText
        descriptionLabel.text = descriptiontText
        descriptionLabel.numberOfLines = 0
        self.contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameStatsStackView.snp.bottom)
                .inset(-Constants.Layout.verticalSpace)
            make.horizontalEdges.equalToSuperview()
                .inset(Constants.Layout.horizontalSpace)
            make.bottom.equalToSuperview()
                .inset(Layout.verticalSpace)
        }
    }
    
    func addElementsToNameStatsStackView() {
        self.nameStatsStackView.addArrangedSubview(self.createStatLabel("HP"))
        self.nameStatsStackView.addArrangedSubview(self.createStatLabel("Attack"))
        self.nameStatsStackView.addArrangedSubview(self.createStatLabel("Defence"))
        self.nameStatsStackView.addArrangedSubview(self.createStatLabel("Sp. Atk"))
        self.nameStatsStackView.addArrangedSubview(self.createStatLabel("Sp. Def"))
        self.nameStatsStackView.addArrangedSubview(self.createStatLabel("Speed"))
    }
    
    func addElementsToStatsStackView() {
        self.statsStackView.addArrangedSubview(self.hpLabel)
        self.statsStackView.addArrangedSubview(self.attackLabel)
        self.statsStackView.addArrangedSubview(self.defenseLabel)
        self.statsStackView.addArrangedSubview(self.specialAttackLabel)
        self.statsStackView.addArrangedSubview(self.specialDefenseLabel)
        self.statsStackView.addArrangedSubview(self.speedLabel)
    }
    
    func addElementsToMarksStackView() {
        self.marksStackView.addArrangedSubview(self.hpMarkStackView)
        self.marksStackView.addArrangedSubview(self.attackMarkStackView)
        self.marksStackView.addArrangedSubview(self.defenseMarkStackView)
        self.marksStackView.addArrangedSubview(self.specialAttackMarkStackView)
        self.marksStackView.addArrangedSubview(self.specialDefenseMarkStackView)
        self.marksStackView.addArrangedSubview(self.speedMarkStackView)
    }
    
    func createStatLabel(_ name: String) -> UILabel {
        let statLabel = UILabel()
        statLabel.font = Constants.Fonts.aboutPokemonText
        statLabel.textColor = Constants.Colors.aboutPokemonText
        statLabel.text = name
        statLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        return statLabel
    }
    
    func createViewForStat(isEmpty: Bool, color: UIColor) -> UIView {
        let conteiner = UIView()
        conteiner.transform = CGAffineTransform(rotationAngle: 0.3)
        conteiner.snp.makeConstraints { make in
            make.width.equalTo(Layout.widthConteinerViewStat)
            make.height.equalTo(Layout.heightConteinerViewStat)
        }
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = color
        conteiner.addSubview(view)
        view.snp.makeConstraints { make in
            make.width.equalTo(Layout.widthViewStat)
            make.height.equalTo(Layout.heightViewStat)
            make.centerY.equalToSuperview()
        }
        if isEmpty {
            view.backgroundColor = .darkGray
        }
        return conteiner
    }
    
    func createArrayView(mark: Int, color: UIColor, stackView: UIStackView) {
        let coefficientMarkView = 17
        let countMarkView = mark / coefficientMarkView
        if stackView.arrangedSubviews.isEmpty {
            for i in 1...15 {
                if i <= countMarkView {
                    stackView.addArrangedSubview(self.createViewForStat(isEmpty: false, color: color))
                } else {
                    stackView.addArrangedSubview(self.createViewForStat(isEmpty: true, color: color))
                }
            }
        }
    }
}

fileprivate enum Layout
{
    static let heightConteinerViewStat = 35
    static let widthConteinerViewStat = 11
    static let heightViewStat = 22
    static let widthViewStat = 11
    static let verticalSpace = 32
}
