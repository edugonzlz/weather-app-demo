# Weather Demo Project

Weather Demo Project is a little wheather app for present some programming concepts for iOS.

### App features:

- Displays the current air quality of Munich (lat = 48.13743, lon = 11.57549), as well as a forecast. 
- Air quality data can be obtained via OpenWeatherMap
- Current air quality is on top
- Forecast list below current air quality
- All rows have a background color corresponding to the air quality (traffic light): Good = green, Fair = green, Moderate = yellow, Poor = red, Very Poor = red
- The whole screen is scrollable
- Tap on either current or forecast will display a detail view, listing all air components and their values

### Notes:
- Use Swift 5.3
- Don't use third party libraries
- Use Viper architecture
- Use SOLID and Clean architecture concepts

### File structure:
- Application: Contains funcionality about app start and app state if necessary (user login state, app state...) 
- Global: Constants for use in the app
- Sections: Screens constructed with VIPER
- Common: Code that is needed in all app
	- Services: Configure the data to make network calls or database calls
	- Managers: Are responsible of handle data from diferent places, like network, database...
	- Models: Entities used in the app
	- Extensions: Agroup extensions for increase code funcionality
	- Views: Views used in all the app
	- Protocols: Protocol declaration with default implementation if needed
- Resources: Graphic resources
- Support Files: Files needed by the project