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
    
    func configure(hp: Int, attack: Int, defense: Int, specialAttack: Int, specialDefense: Int, speed: Int, color: UIColor) {
        self.hpLabel.text = "\(hp)"
        self.createArrayView(mark: hp, color: color, stackView: hpMarkStackView)
        self.attackLabel.text = "\(attack)"
        self.createArrayView(mark: attack, color: color, stackView: attackMarkStackView)
        self.defenseLabel.text = "\(defense)"
        self.createArrayView(mark: defense, color: color, stackView: defenseMarkStackView)
        self.specialAttackLabel.text = "\(specialAttack)"
        self.createArrayView(mark: specialAttack, color: color, stackView: specialAttackMarkStackView)
        self.specialDefenseLabel.text = "\(specialDefense)"
        self.createArrayView(mark: specialDefense, color: color, stackView: specialDefenseMarkStackView)
        self.speedLabel.text = "\(speed)"
        self.createArrayView(mark: speed, color: color, stackView: speedMarkStackView)
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
                .inset(32)
            
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

        addElementsToMarksStackView()
        
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1)
        descriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        descriptionLabel.text = descriptiontText
        descriptionLabel.numberOfLines = 0
        self.contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameStatsStackView.snp.bottom)
                .inset(-Constants.Layout.verticalSpace)
            make.horizontalEdges.equalToSuperview()
                .inset(Constants.Layout.horizontalSpace)
            make.bottom.equalToSuperview()
                .inset(32)
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
            make.width.equalTo(11)
            make.height.equalTo(35)
        }
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = color
        conteiner.addSubview(view)
        view.snp.makeConstraints { make in
            make.width.equalTo(11)
            make.height.equalTo(22)
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
