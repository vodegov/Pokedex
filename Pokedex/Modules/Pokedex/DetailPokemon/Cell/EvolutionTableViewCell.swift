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
    
    func configure(nameFirstStep: String, nameSecondStep: String?, nameThirdStep: String?, idFirstStep: Int, levelFirstText: Int?, levelSecondText: Int?, firsdDataImage: Data, secondDataImage: Data?, thirdDataImage: Data?) {
        let firstEvolutionStep = createPokemonEvolutionStep(topView: self.contentView, pokemonIdText: idFirstStep, pokemonNameText: nameFirstStep, isFirst: true, isLast: nameSecondStep == nil ? true : false, levelText: levelFirstText ?? 0, dataImage: firsdDataImage)
        self.contentView.addSubview(firstEvolutionStep)
        
        let secondEvolutionStep = createPokemonEvolutionStep(topView: firstEvolutionStep, pokemonIdText: idFirstStep, pokemonNameText: nameSecondStep ?? "", isLast: nameThirdStep == nil ? true : false, levelText: levelSecondText ?? 0, dataImage: secondDataImage ?? Data())
        self.contentView.addSubview(secondEvolutionStep)
        
        let thirdEvolutionStep = createPokemonEvolutionStep(topView: secondEvolutionStep, pokemonIdText: idFirstStep, pokemonNameText: nameThirdStep ?? "", isLast: true, levelText: 0, dataImage: thirdDataImage ?? Data())
        self.contentView.addSubview(thirdEvolutionStep)
        
        
    }

}

private extension EvolutionTableViewCell
{
    func buildUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    func createPokemonEvolutionStep(topView: UIView, pokemonIdText: Int, pokemonNameText: String, isFirst: Bool = false, isLast: Bool = false, levelText: Int, dataImage: Data) -> UIView {
        if pokemonNameText == "" {
            return UIView()
        }
        let conteinerView = UIView()
        self.contentView.addSubview(conteinerView)
        conteinerView.snp.makeConstraints { make in
            if isFirst {
                make.top.equalToSuperview()
                    .inset(52)
            } else {
                make.top.equalTo(topView.snp.bottom)
                    .inset(-70)
            }
            make.centerX.equalToSuperview()
            if isLast {
                make.bottom.equalToSuperview()
                    .inset(32)
            }

        }
        
        let backgraundTable = UIView()
        backgraundTable.layer.cornerRadius = 8
        backgraundTable.backgroundColor = .darkGray
        conteinerView.addSubview(backgraundTable)
        backgraundTable.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(87)
            make.width.equalTo(134)
            if isLast {
                make.bottom.equalToSuperview()
            }
        }
        
        let pokemonImage = UIImageView()
        pokemonImage.contentMode = .scaleAspectFit
        pokemonImage.image = UIImage(data: dataImage)
        backgraundTable.addSubview(pokemonImage)
        pokemonImage.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(170)
        }
        
        let pokemonIdLabel = UILabel()
        pokemonIdLabel.font = Constants.Fonts.aboutPokemonText
        pokemonIdLabel.textColor = .darkGray
        pokemonIdLabel.textAlignment = .left
        pokemonIdLabel.text = "#\(pokemonIdText)"
        
        conteinerView.addSubview(pokemonIdLabel)
        pokemonIdLabel.snp.makeConstraints { make in
            make.top.equalTo(backgraundTable)
            make.leading.equalTo(backgraundTable.snp.trailing)
                .inset(-Constants.Layout.horizontalSpace)
            make.trailing.equalToSuperview()
        }
        
        let pokemonNameLabel = UILabel()
        pokemonNameLabel.textAlignment = .left
        pokemonNameLabel.textColor = Constants.Colors.defaulText
        pokemonNameLabel.font = Constants.Fonts.nameTextEvolution
        pokemonNameLabel.text = pokemonNameText.capitalized
        
        conteinerView.addSubview(pokemonNameLabel)
        pokemonNameLabel.snp.makeConstraints { make in
            make.top.equalTo(pokemonIdLabel.snp.bottom)
                .inset(4)
            make.leading.equalTo(pokemonIdLabel)
            make.trailing.equalToSuperview()
            make.height.equalTo(23)
        }
        
        if !isLast {
            let arrowImage = UIImageView()
            arrowImage.image = UIImage(named: "arrow")
            conteinerView.addSubview(arrowImage)
            arrowImage.snp.makeConstraints { make in
                make.top.equalTo(backgraundTable.snp.bottom)
                    .inset(-17)
                make.centerX.equalTo(backgraundTable)
                make.bottom.equalToSuperview()
                
            }
            
            let levelUpLabel = UILabel()
            conteinerView.addSubview(levelUpLabel)
            levelUpLabel.font = UIFont(name: "Montserrat", size: 14)
            levelUpLabel.text = levelText != 0 ? "Level \(levelText)" : "Level unknown"
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
