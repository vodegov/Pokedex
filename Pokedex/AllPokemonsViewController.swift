
import UIKit
import SnapKit

final class AllPokemonsViewController: UIViewController
{

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        
        let label = UILabel()
        label.text = "cjkdhbcdhjbc"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
