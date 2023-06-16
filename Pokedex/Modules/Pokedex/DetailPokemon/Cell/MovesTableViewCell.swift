import UIKit

final class MovesTableViewCell: UITableViewCell
{
    private lazy var collectionView = makeCollectionView()
    private var movesData: [Moves] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMovesData(model: [Moves]) {
        self.movesData = model
    }
}

private extension MovesTableViewCell
{
    
    func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Constants.Colors.background
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovesCollectionViewCell.self,
                                forCellWithReuseIdentifier: "MovesCollectionViewCell")
        collectionView.backgroundColor = .clear
        return collectionView
    }
    
    func setupCollectionView() {
        self.contentView.addSubview(collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(Layout.heightCollectionView)
        }
    }
}

extension MovesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.movesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "MovesCollectionViewCell", for: indexPath) as? MovesCollectionViewCell else { return UICollectionViewCell() }
        let moveName = self.movesData[indexPath.row].move.name
        cell.configure(name: moveName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width,
                      height: Layout.heightCollectionViewCell)
    }
}
fileprivate enum Layout
{
    static let heightCollectionView = 300
    static let heightCollectionViewCell: CGFloat = 70
}
