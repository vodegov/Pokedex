import UIKit

protocol IAlert: AnyObject
{
    var alertDeletehandler: (() -> ())? { get }
    func showAlertDelete(title: String, msg: String, `on` controller: UIViewController)
    func showAlertBadSearch(msg: String, `on` controller: UIViewController)
    func showAlertError(title: String, msg: String, `on` controller: UIViewController)
}

final class Alert: IAlert
{
    var alertDeletehandler: (() -> ())?
    
    func showAlertDelete(title: String, msg: String, `on` controller: UIViewController) {
        let alertDelete = UIAlertController(title: title,
                                            message: msg,
                                            preferredStyle: .alert)
        
        let cancleAction = UIAlertAction(title: "Cancle", style: .default)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.alertDeletehandler?()
        }
        alertDelete.addAction(deleteAction)
        alertDelete.addAction(cancleAction)
        controller.present(alertDelete, animated: true)
    }
    
    func showAlertBadSearch(msg: String, `on` controller: UIViewController) {
        let alertIncorrectName = UIAlertController(title: .none,
                                            message: msg,
                                            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertIncorrectName.addAction(okAction)
        controller.present(alertIncorrectName, animated: true)
    }
    
    func showAlertError(title: String, msg: String, `on` controller: UIViewController) {
        let alertIncorrectName = UIAlertController(title: title,
                                            message: msg,
                                            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            controller.navigationController?.popViewController(animated: true)
        }
        alertIncorrectName.addAction(okAction)
        controller.present(alertIncorrectName, animated: true)
    }
}
