//
//  ContentView.swift
//  SwiftUISamples
//
//  Created by Timothy Miller on 9/3/21.
//

import AVKit
import SwiftUI

struct ContentView: View {
    init() {
        // Color Tab Bar manually. If we have a list or form the tab bar will
        // get the secondarySystemBackground color applied by default.
        // Option 1
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .secondarySystemBackground

        UITabBar.appearance().standardAppearance = tabBarAppearance

        if #available(iOS 15, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        
        // Option 2
//        UITabBar.appearance().isTranslucent = false
//        UITabBar.appearance().isOpaque = true
//        UITabBar.appearance().backgroundColor = .secondarySystemBackground
    }
    
    var body: some View {
        TabView {
            ValidationSampleView()
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Validation")
                }
            
            SearchBarSampleView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            ImageSelectionSampleView()
            .tabItem {
                Image(systemName: "photo")
                Text("Image Selection")
            }
        }
    }
}

struct ValidationSampleView: View {
    @State private var value = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Prompt")
                TextField("Prompt", text: $value)
                    .validated(isValid: {
                        value.count < 11

                    }, validationMessage: "Too many!")

                HStack {
                    Spacer()
                    Button("Test Button", action: {})
                        .padding(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24))
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    Spacer()
                }
            }
            .padding()
            .navigationTitle("Validation")
        }
    }
}

struct SearchBarSampleView: View {
    @State private var names = ["Tim", "Jon", "Will", "Chad", "Sara", "Steve", "Megan"]
    @State private var searchText = ""
    
    private var filteredNames: [String] {
        if !searchText.isEmpty {
            return names.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
        
        return names
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                List {
                    ForEach(filteredNames, id: \.self) { name in
                        Text(name)
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .navigationTitle("Search")
        }
    }
}

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        ContentView().preferredColorScheme(.dark)
    }
}
