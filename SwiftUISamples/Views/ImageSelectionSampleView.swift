//
//  ImageSelectionSampleView.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 10/12/21.
//

import AVKit
import SwiftUI

struct ImageSelectionSampleView: View {
    @State private var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var isActionSheetPresented = false
    @State private var isImagePickerPresented = false
    @State private var isPermissionAlertPresented = false
    
    @State private var imageName = ""
    @State private var imageDescription = ""
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: HStack {
                    Spacer()
                    Button(action: selectImageAction) {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 150)
                                .padding(EdgeInsets(top: 0, leading: 45, bottom: 0, trailing: 45))
                        } else {
                            Image(systemName: "photo.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 150)
                                .padding(EdgeInsets(top: 0, leading: 45, bottom: 0, trailing: 45))
                                .foregroundColor(.secondary)
                        }
                    }
                    Spacer()
                }
                            .padding([.top, .bottom], 35)) {
                    TextField("Name", text: $imageName)
                    if #available(iOS 15, *) {
                        TextField("\(String(localized: "Description")) OptionalFieldFormat", text: $imageDescription)
                    } else {
                        TextField("\("Description".localized()) OptionalFieldFormat", text: $imageDescription)
                    }
                }
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(sourceType: $imagePickerSourceType, allowsEditing: true, image: $selectedImage)
            }
            .actionSheet(isPresented: $isActionSheetPresented) {
                ActionSheet(title: Text("Select Source"), message: nil, buttons: [
                    .default(Text("Take Photo")) {
                        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                            return
                        }
                        
                        imagePickerSourceType = .camera
                        isImagePickerPresented.toggle()
                    },
                    .default(Text("Photo Library")) {
                        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                            return
                        }
                        
                        imagePickerSourceType = .photoLibrary
                        isImagePickerPresented.toggle()
                    },
                    .cancel()
                ])
            }
            .alert(isPresented: $isPermissionAlertPresented) {
                Alert(title: Text("CameraPermissionAlertTitle"), message: Text("CameraPermissionAlertMessage"),
                      primaryButton: .default(Text("Yes")) {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }, secondaryButton: .cancel(Text("No")))
            }
            .navigationTitle("Image Selection")
        }
    }
    
    private func selectImageAction() {
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            isActionSheetPresented.toggle()
        } else {
            requestCameraAccess()
        }
    }
    
    private func requestCameraAccess() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                isActionSheetPresented.toggle()
            } else {
                // If permission has been denied by the user, alert them that they must set permissions by opening up the app settings
                isPermissionAlertPresented.toggle()
            }
        }
    }
}

struct ImageSelectionSampleView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelectionSampleView()
        
        ImageSelectionSampleView().preferredColorScheme(.dark)
    }
}
