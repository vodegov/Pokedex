import UIKit

class EvolutionTableViewCell: UITableViewCell
{
    private let pokeminImage = UIImageView()
    private let pokemonIdLabel = UILabel()
    private let pokemonNameLabel = UILabel()
    private let pokemonTypeImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EvolutionTableViewCell: ITableViewCell
{
    typealias Model = EvolutionCellModel
    
    func configure(model: EvolutionCellModel) {
        let firstEvolutionStep = createPokemonEvolutionStep(topView: self.contentView,
                                                            pokemonNameText: model.nameFirstStep,
                                                            isFirst: true,
                                                            isLast: model.nameSecondStep == "" ? true : false,
                                                            levelText: model.levelFirstText ?? 0,
                                                            dataImage: model.firsdDataImage)
        self.contentView.addSubview(firstEvolutionStep)
        
        let secondEvolutionStep = createPokemonEvolutionStep(topView: firstEvolutionStep,
                                                             pokemonNameText: model.nameSecondStep ?? "",
                                                             isLast: model.nameThirdStep == "" ? true : false,
                                                             levelText: model.levelSecondText ?? 0,
                                                             dataImage: model.secondDataImage)
        self.contentView.addSubview(secondEvolutionStep)
        
        let thirdEvolutionStep = createPokemonEvolutionStep(topView: secondEvolutionStep,
                                                            pokemonNameText: model.nameThirdStep ?? "",
                                                            isLast: true, levelText: 0,
                                                            dataImage: model.thirdDataImage)
        self.contentView.addSubview(thirdEvolutionStep)
        
        
    }
}

private extension EvolutionTableViewCell
{
    func buildUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    func createPokemonEvolutionStep(topView: UIView,
                                    pokemonNameText: String,
                                    isFirst: Bool = false,
                                    isLast: Bool = false,
                                    levelText: Int,
                                    dataImage: Data?) -> UIView {
        if pokemonNameText == "" {
            return UIView()
        }
        let conteinerView = UIView()
        self.contentView.addSubview(conteinerView)
        conteinerView.snp.makeConstraints { make in
            if isFirst {
                make.top.equalToSuperview()
                    .inset(LocalConstant.Layout.topContreintToSuperview)
            } else {
                make.top.equalTo(topView.snp.bottom)
                    .inset(-LocalConstant.Layout.topContreintToNextView)
            }
            make.centerX.equalToSuperview()
            if isLast {
                make.bottom.equalToSuperview()
                    .inset(LocalConstant.Layout.botContreintToSuperview)
            }

        }
        
        let backgraundTable = UIView()
        backgraundTable.layer.cornerRadius = 8
        backgraundTable.backgroundColor = .darkGray
        conteinerView.addSubview(backgraundTable)
        backgraundTable.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(LocalConstant.Layout.heightBackgraundTable)
            make.width.equalTo(LocalConstant.Layout.widthBackgraundTable)
            if isLast {
                make.bottom.equalToSuperview()
            }
        }
        
        let pokemonImage = UIImageView()
        pokemonImage.contentMode = .scaleAspectFit
        if let dataImage = dataImage {
            pokemonImage.image = UIImage(data: dataImage)
        } else {
            pokemonImage.image = UIImage(named: "emptyPokemon")
        }
        backgraundTable.addSubview(pokemonImage)
        pokemonImage.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(LocalConstant.Layout.heightPokemonImage)
        }
        
        let pokemonNameLabel = UILabel()
        pokemonNameLabel.textAlignment = .left
        pokemonNameLabel.textColor = Constants.Colors.defaulText
        pokemonNameLabel.font = Constants.Fonts.nameTextEvolution
        pokemonNameLabel.text = pokemonNameText.capitalized
        
        conteinerView.addSubview(pokemonNameLabel)
        pokemonNameLabel.snp.makeConstraints { make in
            make.top.equalTo(backgraundTable)
            make.leading.equalTo(backgraundTable.snp.trailing)
                .inset(-Constants.Layout.horizontalSpace)
            make.trailing.equalToSuperview()
        }
        
        if !isLast {
            let arrowImage = UIImageView()
            arrowImage.image = UIImage(named: "arrow")
            conteinerView.addSubview(arrowImage)
            arrowImage.snp.makeConstraints { make in
                make.top.equalTo(backgraundTable.snp.bottom)
                    .inset(-LocalConstant.Layout.spaceArrowToTable)
                make.centerX.equalTo(backgraundTable)
                make.bottom.equalToSuperview()
                
            }
            
            let levelUpLabel = UILabel()
            conteinerView.addSubview(levelUpLabel)
            levelUpLabel.font = LocalConstant.fontLevelUp
            levelUpLabel.text = levelText != 0
            ? "Level \(levelText)"
            : "Level unknown"
            levelUpLabel.textColor = .white
            levelUpLabel.snp.makeConstraints { make in
                make.leading.equalTo(arrowImage.snp.trailing)
                    .inset(-Constants.Layout.horizontalSpace)
                make.centerY.equalTo(arrowImage)
            }
        }
        
        return conteinerView
    }
}

fileprivate enum LocalConstant
{
    static let fontLevelUp = UIFont(name: "Montserrat", size: 14)
    
    enum Layout
    {
        static let spaceArrowToTable = 17
        static let heightPokemonImage = 170
        static let heightBackgraundTable = 87
        static let widthBackgraundTable = 134
        static let botContreintToSuperview = 32
        static let topContreintToSuperview = 52
        static let topContreintToNextView = 70
    }
}
