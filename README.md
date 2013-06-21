PlaceKit
========

Placeholders, lorem ipsum, and fake data oh my!

For all of your early-development, sandbox and proto work. PlaceKit is an easy-to-use framework for adding content when you either have none or don't care what it is during the early phases of development.

##Content
###Placeholder Content

Nothing motivates a designer more than seeing random meat-based assets on an app they have to work with.

- Placeholder images
    - Random images from [placekitten.com](http://placekitten.com)
    - Random images from [baconmockup.com](http://baconmockup.com)
    - Random images from [lorempixel.net](http://lorempixel.com)
    - Placeholder images from [placehold.it](http://placehold.it)
- Placeholder text
    - Hipster based text from [hipsteripsum.me](http://hipsteripsum.me)
    - Lorem Ipsum text/HTML/HTML URLs from [loripsum.net](http://loripsum.net)
- Fake data
    - Person names
    - Business names
    - Phone numbers
    - Random numbers

###Random Geometry & Numbers

Easily generate views with random frames within another view, pick a random point within a given rect or generate random numbers and percentages:

- Random CGSize
- Random CGRect
- Random CGRect enclosed in CGRect
- Random CGPoint enclosed in CGRect
- Random percentages
- Random numbers in range

###Random Colors

Create new colors to give you bland UI some dimension, give new views a random color to tell them apart or generate a new random color matching the hue of another:

- Fully random UIColor
- Random UIColor with hue
- Random UIColor with same hue as another color
- Random greyscale color
- More

##Installation
###CocoaPods
The easiest way to use PlaceKit is using CocoaPods: `pod 'PlaceKit'`

If you would like to use the `UIImageView` categories for the placeholder images, you will need to use the 'ImageView' subspec: `pod 'PlaceKit/ImageView'`. This will install the AFNetworking as a dependency in order to use `UIImageView+AFNetworking`.

###Standalone
The PlaceKit core was built dependency-free to make it as easy as possible to drop into your project. Simply drop `PlaceKit.{h,m}` into your project and import as necessary! If you would like to use the `UIImageView` category, you will also need to integrate AFNetworking into your project.

##License

Standard MIT license