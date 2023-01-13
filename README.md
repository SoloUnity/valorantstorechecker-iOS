<div align="left">
  <h1>
  Valorant Store Checker
  </h1>
  <img width="100" alt="VSC-1 (dragged)" src="https://user-images.githubusercontent.com/77747704/183313304-d6343e5b-6679-4783-ad26-f277af996b6b.png">
</div>



### Description
VSC (Valorant Store Tracker) is an open source iOS app that allows you to track your store and preview your skins. It allows for easy on the go access to your otherwise unaccessible skin shop as well as a place to easily preview everything before buying. 

### Installation
<p align=center>
  <a href="https://apps.apple.com/app/id1637273546" target="_blank" rel="noreferrer"><img height="75" alt="VSC-1 (dragged)" src="https://user-images.githubusercontent.com/77747704/184449890-c3620a49-6303-494e-8bcb-f0fd005b9a6d.png">
</p>
   
### Community
Join the [Discord](https://discord.gg/vK5mzjvqYM) server to chat around or for support!
See the [Website](https://valorantstore.net) if you wish to check your store on your computer.

### Screenshots

<p align=center>
  <img width="32%" src="https://user-images.githubusercontent.com/77747704/212138466-0d2dcb47-ade3-418a-b249-b99448087a41.png" />
  <img width="32%" src="https://user-images.githubusercontent.com/77747704/212136317-2f9f4fc7-67d8-4d0b-b433-0f5715ef59c4.png" />
  <img width="32%" src="https://user-images.githubusercontent.com/77747704/212136635-bc9c4c05-7d04-4911-b4e2-6382236da6d3.png" />
</p>

<p align=center>
  <img width="24%" src="https://user-images.githubusercontent.com/77747704/212137194-c5703512-b305-43b7-bb35-425a802ac3ac.png" />
  <img width="24%" src="https://user-images.githubusercontent.com/77747704/212136315-e59742e9-f84c-4756-b0be-73161d38d0fb.png" />
  <img width="24%" src="https://user-images.githubusercontent.com/77747704/212136640-e03aaa83-bef1-471e-8179-637b62b56c15.png" />
  <img width="24%" src="https://user-images.githubusercontent.com/77747704/212136630-ff11a448-a1a9-4fe5-b83f-c3b4e9be0755.png" />
</p>

### Frequently Asked Questions

#### Why does the app need my login information?

While many of your statistics are free to access without your password, your store is a notable exception as it is considered sensitive information. In order for the app to access your store, it needs your login information where it obtains your store through this [open source API](https://github.com/HeyM1ke/ValorantClientAPI).

#### What are the measures in place to protect me?

In addition to never storing your password, sensitive information including your region is secured behind Keychain. The app is also open source, allowing anybody and everyone to access the code at all times. Your privacy is a priority, and I have done everything in my power to ensure it. For legal mumbo jumbo, see [here](https://www.craft.do/s/fQxdg6aSyp8WAk).

#### What assets are downloaded?

If you are perceptive, you will notice that the app downloads assets on your first launch. These are image assets allowing you to use the app's Skin index feature at all times, even when offline. 

#### What does remember password do?
The current way that the reload button requires cookies instead of your username and password, allowing the app to not store your password at all. However, these cookies expire after a certain period, requiring the user to sign in again. In order to streamline this process, remember password allows the user to save their password and allow for automatic behind the scenes sign in. If the user wishes to not save the password, they can simply sign out and sign back in to create new cookies.  

### Roadmap Checklist
- [x] Vietnamese Localization
- [ ] Code cleanup
- [ ] Add skin chroma videos
- [x] Redesign UI for a cohesive feeling
- [ ] Add valorant news, new skins, previous stores
- [ ] Improve owned skins
- [ ] Minimize network calls and data usage
- [ ] Implement CoreData
- [x] Have an accurate download bar for downloading skins
- [ ] Add reference tab for vp price
- [ ] Widgets
- [ ] User customization of colour scheme and app icon
- [ ] Monetization strategy (of new features only, core features are free)
- [ ] Notify when skin is in shop

### Help Translate
You can help the translation with a pull request of relevant Localizable.strings file from the correct language.lproj folder [here](https://github.com/SoloUnity/Valorant-Store-Checker-App/tree/main/ValorantStoreChecker/Ressources). The majority of these translations were done with DeepL or Google Translate. 

### Acknowledgements
Thank you to the following people and repositories:

- **[juliand665](https://github.com/juliand665)** for their invaluable help in answering my many SwiftUI question.
- **[Lunac-dev](https://github.com/Lunac-dev)** for his continuous support and creation of the Valorant Store Checker project.
- **[RumbleMike/ValorantClientAPI](https://github.com/RumbleMike/ValorantClientAPI)** for the API that makes it all possible.
- **[techchrism/valorant-api-docs](https://github.com/techchrism/valorant-api-docs)** for the detailed documentation.
- **[Valorant-API.com](https://valorant-api.com)** for providing assets.

### TOS and Privacy Policy
TOS follows the [MIT License](https://github.com/SoloUnity/Valorant-Store-Checker-App/blob/main/License)

[Privacy Policy](https://www.craft.do/s/fQxdg6aSyp8WAk)




