## Build tools & versions used

    - Built with xCode, SwiftUI and with minimum version iOS 14

## Steps to run the app

    - Launch xCode and wait few minutes for the "swift-collections" package to download provided by Apple. Change the minimum deployment version in the "General" tab to iOS 14 if its'
    not done automatically for you. Note if the "swift-collections" package doesn't download automatically then select:
        1. File
        2. Packages
        3. Reset Package Caches

## What areas of the app did you focus on?
    
    - I focused on providing a flexible networking layer so that if different networking requirements come into place we just need to add the requirements to the APIService protocol.
    This will allow for simple unit testing by injecting mock classes to the view model init. 
    
    - Adding a protocol for the endpoints too will allow to check the successful state, empty state, and error state just by changing the enum value in the 
    unit tests and debudding. 
    
    - Lastly I also focused on the UI / UX as this is what I am most passionate about when designing an app. 
    
    - In addition I also focused on networking bandwidth when it comes to decoding and downsampling image sizes when downloading images through a network request. 

## What was the reason for your focus? What problems were you trying to solve?

    - The reason for creating a flexible service client were the endpoint enum and services struct conform to a protocol was so we can inject mocks when it comes to unit testing. I also wanted a way to easily switch between the end points for this project and verify the different responses simply by changing the enum. 
    
    - To do this I created a Resource struct which takes in the enum endpoint and a default .get httpMethod (its set as default just for the purpose of this assignment). The Resource struct can also take in any object through the generic type. That way when inside the request function all of the logic to create the url and having an instance of what the decoding type needs to be is done through the Resource object that we pass in as a parameter. Having the function also take in a generic type makes the service call flexible to be used with different object types.
    
    - Created an engaging UI to follow some of apples HIG. For example using the built in system font sizes so that the project can handle dynamic fonts for accessibility. Added a loading indicator to signal that the users contact information is currently being downloaded, telling the user that some sort of action is being made currently while not locking the UI. Since I am using iOS 14+ too I used LazyVStack and LazyHStack. By default, SwiftUI’s VStack and HStack in iOS13 load all their contents up front, which is likely to be slow if you use them inside a scroll view. To enhance memory usage and storage consumption and load content lazily you should use LazyVStack and LazyHStack. Lastly added two ways to refresh data, iOS 15 has a built in pull to refresh feature for swiftUI, but versions below 15 will use a button to refresh the data. 
    
    - Focused on also using a caching singleton to store images that has a count limit of 200 and a total cost limit. Also added a downsampling feature for the images for better memomry consumption and scrolling performance for the grid. Having the downsampling decreases the memomry by 41 % when using the large image url. 

## How long did you spend on this project?

    - 5 hours 

## Did you make any trade-offs for this project? What would you have done differently with more time?

    - One trade off was using iOS 14. SwiftUI is much easier to use in iOS 14+ but it is still manageable with iOS 13. It just requires more time as you need to use more UIKit views and connect them with SwiftUI using UIVIewRepresentable which is more difficult to implement.
    
    - Also with the dynamic types when passing a certain size the font expands outside of the card. In iOS 15 you can set a maximum size increase but for versions below it requires a hacky solution that I would need to investigate more. 
    
    - More unit tests, I made my cache a singleon, the networking call for the image is in the view model. Would of prefered moving the networking logic in the APIServiceClass and have the requirement function for image in the APIService protocol so can unit test it. Also would of liked to do more research on the cache, I have seen examples were people have a time stamp for how long the cache should remain too. 
    
    - Use only apple async concurency framework to make networking calls. Some areas of the app I use the async concurrency framework but other areas I used combine. For time sake I pulled in the caching and image loading from one my personal projects that uses combine. With more time I would like to convert the image networking call to use async as well so that all the networking calls use the same framework provided by Apple. In SwiftUI iOS 14 and up I could have also used the build in AsyncImage view but the cache logic is still limited with this feature I believe.
    
    - Grouping the employee by their employee type is done by the first letter. So since Contract starts with C this will be the first group displayed in the grid. Would of prefered to have the grouping logic be done some other way. An example would be to assign an Int value so that we can re-order the logic base on the types int position instead of through a character.
    
    - Add a fade in animation for the cards when finished loading

## What do you think is the weakest part of your project?

    - The networking logic for downloading the images being in the view model as well as using a singleton to cache the images. 
    - Dynamic fonts not being handled correctly in the cards when once they pass a certain size

## Did you copy any code or dependencies? Please make sure to attribute them here!

    - Copied the networking implementation to download, cache and downsample images from one my person projects. 
    - Copied the logic to use KeyPaths for sorting and mapping from an online resource. This is in the extension Sequence file
    - Also used in one of apples open source package called "swift-collections" to group the employees by their employment type (full time, part time, contract)
    - Copied the Resource struct logic to make it work with a generic service call from one of my personal projects

## Is there any other information you’d like us to know?
    - Built using the iPhone X models, also works both in portrait and landscape mode. 
    - Kept all branches so can checkout each branch to see which portion of the work was done on a specific branch
    - To demonstrate my experience in UI / UX I chose SwiftUI but would also have been capable in creating project in UIKit progrmatically. 
    - To check the error, and empty response in the following file: simonmcneil_squareprojectApp change the endpoint enum value in the .init
