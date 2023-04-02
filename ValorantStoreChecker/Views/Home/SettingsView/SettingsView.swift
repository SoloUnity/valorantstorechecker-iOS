//
//  SettingsView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-22.
//

import SwiftUI


extension View {
    
    func bgClear() -> some View {
        
        if #available(iOS 16.0, *) {
            return self.scrollContentBackground(.hidden)
        }
        else {
            UITableView.appearance().backgroundColor = .clear
            return self
        }
        
        
    }
}
 
struct SettingsView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @EnvironmentObject var alertModel : AlertModel
    @AppStorage("autoReload") var toggleReload = false
    @AppStorage("notification") var toggleNotification = false
    @AppStorage("requestNotifPerm") var notification : Bool = false
    @State var unhide = false           // Toggle showing / hiding password
    @State private var selectedDate = Date()
    @State var dummy : Bool = false
    @State var hasScrolled = false
    
    let notify = NotificationService()
    let defaults = UserDefaults.standard
 
    var body: some View {
        
        NavigationView {
            
            
            ZStack {
                
                NavigationLink(isActive: $alertModel.openAccounts, destination: { AccountView() }, label: {
                    EmptyView()
                })
                
                
                //Constants.bgGrey.edgesIgnoringSafeArea(.all)
                
                // MARK: Account and Help
                Form {
                    
                    Section() {
                        NavigationLink(destination: AccountView()) {
                            UsernameView()
                                .padding(.vertical, 1)
                                
                                
                        }
                        
                        NavigationLink(destination: HelpView()) {
                            SettingItemView(itemType: "generic", name: "HelpDev", iconBG: .white, iconColour: .red, image: "heart.fill", toggleBool: $dummy)
                        }
                        

                    }
                    
                    // MARK: Reload
                    Section() {
                        
                        SettingItemView(itemType: "toggle", name: "AutomaticReload", iconBG: .green, iconColour: .white, image: "arrow.clockwise", defaultName: "autoReload", toggleBool: $toggleReload)
                        
                        // MARK: Notification
                        if !notification {
                            
                            HStack {
                                SettingItemView(itemType: "generic", name: "Notify", iconBG: .orange, iconColour: .white, image: "bell.fill", removeSpace: false,toggleBool: $dummy)
                                
                                
                                
                                Button {
                                    
                                    notify.askPermission()
                                    
                                    
                                } label: {
                                    Text("Allow")
                                        .font(.callout)
                                        .foregroundColor(.pink)
                                }
                                
                            }
                            
                        }
                        else {
                            
                            SettingItemView(itemType: "toggle", name: "Notify", iconBG: .orange, iconColour: .white, image: "bell.fill", defaultName: "notification", toggleBool: $toggleNotification)
                                .onChange(of: toggleNotification) { boolean in

                                    if toggleNotification {
                                        
                                        // TODO: find out how to localize notifications
                                        
                                        notify.sendNotification(date: defaults.object(forKey: "timeLeft") as? Date ?? Date(), title: "Store Checker for Valorant", body: "Store has just reset")

                                    }
                                    
                                    if !boolean{
                                        notify.disableNotifications()
                                    }
                                    

                                    
                                }
                        }
                        
                        // MARK: Appearance
                        NavigationLink {
                            AppearanceView()
                        } label: {
                            SettingItemView(itemType: "generic", name: "Appearance", iconBG: .cyan, iconColour: .white, image: "iphone", toggleBool: $dummy)
                        }
                        

                        // MARK: Asset Management
                        NavigationLink {
                            MediaManagementView()
                        } label: {
                            SettingItemView(itemType: "generic", name: "ManageMedia", iconBG: .gray, iconColour: .white, image: "photo", toggleBool: $dummy)
                        }
                        
                        // MARK: Language
                        Button {
                            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                            }
                        } label: {
                            SettingItemView(itemType: "generic", name: "Language", iconBG: .blue, iconColour: .white, image: "character.bubble.fill", showChevron: true, removeSpace : false, toggleBool: $dummy)
                            
                        }
                        
                        
                        //LOCALIZETEXT


                        
                        
                        
                        
                    }
                    
                    Section() {
                        // Support
                        NavigationLink {
                            SupportView()
                        } label: {
                            SettingItemView(itemType: "generic", name: "Support", iconBG: .red, iconColour: .white, image: "questionmark.circle.fill", toggleBool: $dummy)
                        }

                        
                        // Community
                        NavigationLink {
                            CommunityView()
                        } label: {
                            SettingItemView(itemType: "generic", name: "Community", iconBG: .mint, iconColour: .white, image: "person.2.fill", toggleBool: $dummy)
                        }
                        
                        // Share button
                        if #available(iOS 16.0, *) {
                            
                            ShareLink(item: URL(string: Constants.URL.appStore)!) {
                                SettingItemView(itemType: "generic", name: "Share", iconBG: .white, iconColour: .black, image: "square.and.arrow.up.fill", showChevron: true, removeSpace : false, toggleBool: $dummy)
                                    .foregroundColor(.black)
                            }

                        }
                        else {
                            Button {
                                
                                guard let urlShare = URL(string: Constants.URL.appStore) else { return }
                                
                                
                                let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
                                
                                let scenes = UIApplication.shared.connectedScenes
                                let windowScene = scenes.first as? UIWindowScene
                                
                                windowScene?.keyWindow?.rootViewController?.present(activityVC, animated: true, completion: nil)
                                
                            } label: {
                                SettingItemView(itemType: "generic", name: "Share", iconBG: .white, iconColour: .black, image: "square.and.arrow.up.fill", showChevron: true, removeSpace : false,toggleBool: $dummy)
                                    .foregroundColor(.black)
                                    
                            }
                        }
                        
                        // Credits
                        NavigationLink {
                            AcknowledgementsView()
                        } label: {
                            SettingItemView(itemType: "generic", name: "Acknowledgements", iconBG: .purple, iconColour: .white, image: "star.fill", toggleBool: $dummy)
                        }
                        
                        
                    }
                    
                    Section() {
                        
                        NavigationLink {
                            AboutView()
                        } label: {
                            SettingItemView(itemType: "generic", name: "About", iconBG: .gray, iconColour: .white, image: "info.circle.fill", toggleBool: $dummy)
                        }
                        
                        
                    }
                    
                    // Extra Space
                    Section(header: Text("")) {
                        EmptyView()
                        
                    }
                    
                }
                .navigationTitle(LocalizedStringKey("Settings"))
                //.bgClear()
            }
        }

    }
}


