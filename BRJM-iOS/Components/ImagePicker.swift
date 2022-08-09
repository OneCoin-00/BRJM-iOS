import UIKit

public protocol ImagePickerDelegate: AnyObject {
    func didSelect(image: UIImage?, info: [UIImagePickerController.InfoKey: Any])
}

open class ImagePicker: NSObject {

    private let pickerController: UIImagePickerController
    private weak var presentationController: BaseViewController?
    private weak var delegate: ImagePickerDelegate?

    public init(presentationController: BaseViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()

        super.init()

        self.presentationController = presentationController
        self.delegate = delegate

        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }

    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }

        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }

    public func present(from sourceView: UIView) {

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if let action = self.action(for: .camera, title: "camera".localized()) {
            alertController.addAction(action)
        }
        /*
        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
            alertController.addAction(action)
        }
        */
        if let action = self.action(for: .photoLibrary, title: "album".localized()) {
            alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: "cancel".localized(), style: .cancel, handler: nil))

        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }

        self.presentationController?.present(alertController, animated: true)
    }

    public func pickCamera() {
        
        self.pickerController.sourceType = UIImagePickerController.SourceType.camera
        if #available(iOS 13.0, *) {
            self.pickerController.overrideUserInterfaceStyle = .light
        }
        
        // self.pickerController.modalTransitionStyle = .crossDissolve
        self.pickerController.modalPresentationStyle = .fullScreen
        self.presentationController?.present(self.pickerController, animated: true)
    }
    
    public func pickAlbum() {
        
        self.pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        if #available(iOS 13.0, *) {
            self.pickerController.overrideUserInterfaceStyle = .light
        }
        
        // self.pickerController.modalTransitionStyle = .crossDissolve
        self.pickerController.modalPresentationStyle = .fullScreen
        self.presentationController?.present(self.pickerController, animated: true)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?, info: [UIImagePickerController.InfoKey: Any]?) {
        controller.dismiss(animated: true, completion: nil)

        self.delegate?.didSelect(image: image, info: info ?? [:])
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil, info: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil, info: nil)
        }
        self.pickerController(picker, didSelect: image, info: info)
    }
    
}

extension ImagePicker: UINavigationControllerDelegate {

}
