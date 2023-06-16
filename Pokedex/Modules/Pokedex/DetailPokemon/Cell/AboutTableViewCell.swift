import UIKit

final class AboutTableViewCell: UITableViewCell
{
    private lazy var aboutLabel: UILabel = {
        let aboutLabel = UILabel()
        aboutLabel.numberOfLines = 0
        aboutLabel.textColor = Constants.Colors.aboutPokemonText
        aboutLabel.font = Constants.Fonts.aboutPokemonText
        
        return aboutLabel
    }()
    private lazy var viewForInfo: UIView = {
        let viewForInfo = UIView()
        viewForInfo.layer.cornerRadius = LocalConstant.Layout.radiusViewInfo
        viewForInfo.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.1254901961, blue: 0.1333333333, alpha: 1)
        viewForInfo.layer.opacity = 0.7
        
        return viewForInfo
    }()
    private let weightLabel = UILabel()
    private let heightLabel = UILabel()
    private let experienceLabel = UILabel()
    private let catchRateLabel = UILabel()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.buildUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AboutTableViewCell: ITableViewCell
{
    typealias Model = AboutCellModel
    
    func configure(model: AboutCellModel) {
        self.aboutLabel.text = model.about
        let doubleHeight = Double(model.height ?? 0)
        let doubleWeight = Double(model.weight ?? 0)
        self.weightLabel.text = "\(doubleWeight / LocalConstant.coefficientForSize)kg"
        self.heightLabel.text = "\(doubleHeight / LocalConstant.coefficientForSize)m"
        self.experienceLabel.text = "\(model.experience ?? 0)"
        self.catchRateLabel.text = "\(model.catchRate ?? 0)"
    }
}

private extension AboutTableViewCell
{
    func buildUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.contentView.addSubview(self.aboutLabel)
        self.aboutLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .inset(Constants.Layout.verticalSpace)
            make.horizontalEdges.equalToSuperview()
                .inset(Constants.Layout.horizontalSpace)
        }
        
        self.contentView.addSubview(viewForInfo)
        self.viewForInfo.snp.makeConstraints { make in
            make.top.equalTo(self.aboutLabel.snp.bottom)
                .inset(-LocalConstant.Layout.verticalSpace)
            make.horizontalEdges.equalToSuperview()
                .inset(Constants.Layout.horizontalSpace)
            make.height.equalTo(LocalConstant.Layout.heightViewForInfo)
            make.bottom.equalToSuperview()
                .inset(LocalConstant.Layout.verticalSpace)
        }
        
        let lineSeparatorTop = UIView()
        self.viewForInfo.addSubview(lineSeparatorTop)
        lineSeparatorTop.backgroundColor = .darkGray
        lineSeparatorTop.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
                .inset(LocalConstant.Layout.smallVerticalSpace)
            make.height.equalTo(LocalConstant.Layout.heightLineSeporator)
            make.width.equalTo(LocalConstant.Layout.widthLineSeporator)
        }
        
        let lineSeparatorBottom = UIView()
        self.viewForInfo.addSubview(lineSeparatorBottom)
        lineSeparatorBottom.backgroundColor = .darkGray
        lineSeparatorBottom.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
                .inset(LocalConstant.Layout.smallVerticalSpace)
            make.height.equalTo(LocalConstant.Layout.heightLineSeporator)
            make.width.equalTo(LocalConstant.Layout.widthLineSeporator)
        }
        
        let weightConteiner = UIView()
        self.viewForInfo.addSubview(weightConteiner)
        weightConteiner.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .inset(LocalConstant.Layout.smallVerticalSpace)
            make.leading.equalToSuperview()
                .inset(LocalConstant.Layout.leftSpace)
        }
        let weightImage = UIImageView()
        weightImage.image = UIImage(named: "weight")
        weightConteiner.addSubview(weightImage)
        weightImage.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview()
        }
        
        weightConteiner.addSubview(weightLabel)
        self.weightLabel.textColor = .white
        self.weightLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(weightImage.snp.trailing)
                .inset(-Constants.Layout.verticalSpace)
            make.trailing.equalToSuperview()
        }
        
        let weightNameLabel = UILabel()
        weightNameLabel.textColor = .darkGray
        weightNameLabel.text = "Weight"
        self.viewForInfo.addSubview(weightNameLabel)
        weightNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(weightConteiner)
            make.top.equalTo(weightConteiner.snp.bottom)
                .inset(-Constants.Layout.verticalSpace)
        }
        
        let heightConteiner = UIView()
        self.viewForInfo.addSubview(heightConteiner)
        heightConteiner.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .inset(LocalConstant.Layout.smallVerticalSpace)
            make.trailing.equalToSuperview()
                .inset(LocalConstant.Layout.leftSpace)
        }
        let heightImage = UIImageView()
        heightImage.image = UIImage(systemName: "arrow.up")
        heightImage.tintColor = .lightGray
        heightConteiner.addSubview(heightImage)
        heightImage.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview()
        }
        
        heightConteiner.addSubview(self.heightLabel)
        self.heightLabel.textColor = .white
        self.heightLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(heightImage.snp.trailing)
                .inset(-Constants.Layout.verticalSpace)
            make.trailing.equalToSuperview()
        }
        
        let heightNameLabel = UILabel()
        heightNameLabel.textColor = .darkGray
        heightNameLabel.text = "Height"
        self.viewForInfo.addSubview(heightNameLabel)
        heightNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(heightConteiner)
            make.top.equalTo(heightConteiner.snp.bottom)
                .inset(-Constants.Layout.verticalSpace)
        }
        
        let experienceConteiner = UIView()
        self.viewForInfo.addSubview(experienceConteiner)
        experienceConteiner.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
                .inset(LocalConstant.Layout.bigVerticalSpace)
            make.centerX.equalTo(weightConteiner)
        }
        
        let experienceImage = UIImageView()
        experienceImage.image = UIImage(systemName: "graduationcap")
        experienceImage.tintColor = .lightGray
        experienceConteiner.addSubview(experienceImage)
        experienceImage.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview()
        }
        
        experienceConteiner.addSubview(self.experienceLabel)
        self.experienceLabel.textColor = .white
        self.experienceLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(experienceImage.snp.trailing)
                .inset(-Constants.Layout.verticalSpace)
            make.trailing.equalToSuperview()
        }
        
        let experienceNameLabel = UILabel()
        experienceNameLabel.textColor = .darkGray
        experienceNameLabel.text = "Experience"
        self.viewForInfo.addSubview(experienceNameLabel)
        experienceNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(experienceConteiner)
            make.top.equalTo(experienceConteiner.snp.bottom)
                .inset(-Constants.Layout.verticalSpace)
        }
        
        let catchRateConteiner = UIView()
        self.viewForInfo.addSubview(catchRateConteiner)
        catchRateConteiner.snp.makeConstraints { make in
            make.top.equalTo(experienceConteiner)
            make.centerX.equalTo(heightConteiner)
        }
        
        let catchRateImage = UIImageView()
        catchRateImage.image = UIImage(systemName: "percent")
        catchRateImage.tintColor = .lightGray
        catchRateConteiner.addSubview(catchRateImage)
        catchRateImage.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview()
        }
        
        catchRateConteiner.addSubview(self.catchRateLabel)
        self.catchRateLabel.textColor = .white
        self.catchRateLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(catchRateImage.snp.trailing)
                .inset(-Constants.Layout.verticalSpace)
            make.trailing.equalToSuperview()
        }
        
        let catchRateNameLabel = UILabel()
        catchRateNameLabel.textColor = .darkGray
        catchRateNameLabel.text = "Catch rate"
        self.viewForInfo.addSubview(catchRateNameLabel)
        catchRateNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(catchRateConteiner)
            make.top.equalTo(catchRateConteiner.snp.bottom)
                .inset(-Constants.Layout.verticalSpace)
        }
    }
}

fileprivate enum LocalConstant
{
    static let coefficientForSize: Double = 10
    
    enum Layout
    {
        static let radiusViewInfo: CGFloat = 8
        static let verticalSpace: CGFloat = 32
        static let smallVerticalSpace: CGFloat = 25
        static let bigVerticalSpace = 60
        static let heightViewForInfo: CGFloat = 200
        static let heightLineSeporator = 50
        static let widthLineSeporator = 2
        static let leftSpace = 42
        static let rightSpace = 58
    }
}
