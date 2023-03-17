# Weather Forecast

## For the development I used:

- Clean architecture.  
- Web-service with NSURLsession.
- Codable for parsing data.
- Extensions for view shadows, Colors and for others.

## Code Structure:

**Models**            :  I have all model classes in this folder.<br>
**View**              :  UI of the Application.<br>
**module**            :  Project business logic.The communication between view and model.<br>
**Controller**        :  All the controller class are this group. Also I divide classes according to the module.<br>
**Constant**          :  Application constants.<br>
**Resources**         :  Include Application fonts, assist and plist file.<br>


## How this application will works:

- Give the location permission so we can get user location for his current location weather cast.
- We can search city by name. put the City name on search on search field and then press search key on keyboard. If user city exits then it will add automatically. 
- On the click cities click you will land on detail screen. 
- There is a home icon on the top of home page. when you will tap on that you will land back to home screen.


## Note:
- I used to simple way for app demo but I have experice on these listed thing...
- Clean architecture.  (I have experience on VIPER, MVC and MVVM architectures).
- In this project I used Web-service with NSURLsession.(I used a simple use way but I have experience on Alamofire for swift and on AFNetworking for Objective C).
- In this project I used Codable for parsing data.(but In my current job place I am using Object Mapper with VIPER architectures).
- Extensions for view Shadow. (If we have same type of shadows, borders, text and UI then we can create class for UIView, Buttons and for labels and can asign them for code reusability). 





![IMG_0189](https://user-images.githubusercontent.com/44742264/226069193-e368515f-0960-4704-84de-d9b216a48d66.PNG)

![IMG_0190](https://user-images.githubusercontent.com/44742264/226069284-c023ffc7-5cc7-4aa7-b9fd-eecefe18a919.PNG)


https://user-images.githubusercontent.com/44742264/226069470-94fb6147-08f6-4bf0-a0b2-987e5dd2d1ae.mp4





