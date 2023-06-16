import UIKit

protocol IAlert: AnyObject
{
    var alertDeletehandler: (() -> ())? { get }
    func showAlertDelete(title: String, msg: String, `on` controller: UIViewController)
}

final class Alert: IAlert
{
    var alertDeletehandler: (() -> ())?
    
    func showAlertDelete(title: String, msg: String, `on` controller: UIViewController) {
        let alertDelete = UIAlertController(title: title,
                                            message: msg,
                                            preferredStyle: .alert)
        
        let cancleAction = UIAlertAction(title: "Cancle", style: .default)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.alertDeletehandler?()
        }
        alertDelete.addAction(deleteAction)
        alertDelete.addAction(cancleAction)
        controller.present(alertDelete, animated: true)
    }
    
    func showAlertIncorrectName(`on` controller: UIViewController) {
        let alertIncorrectName = UIAlertController(title: .none,
                                            message: "Pokémon name or id entered incorrectly",
                                            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertIncorrectName.addAction(okAction)
        controller.present(alertIncorrectName, animated: true)
    }
}
