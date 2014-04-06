carspark
========

remote start -> spark core -> mifi -> internet <- iphone

### about this project

I started this project to get remote start working on my car from my iPhone. Much like Viper SmartStart or CompuStar’s Drone Mobile.

### current features

* Simple API
  * All calls to the Spark Core can be done through a REST call. This gives me the option to make anything that has an internet connection a remote. Ideas include my TiVo and Pebble watch.
* iOS Client
  * Screenshots
    * http://cl.ly/1z3i0g3I2X1M
    * http://cl.ly/3M1m1i2t1132
* Four buttons are supported on the remote
* Status LED
* Temperature sensor

### feature wish list
* detect when car is running
* detect door lock/unlock state
* gps
* unlock door when phone is within a few feet of the car

### hardware required

* Compustar Remote Start
* Compustar Remote 1WSHR
* Spark Core [spark.io](http://spark.io/)
* FreedomPop Wireless MiFi
* Device running iOS 7+
* Temperature Sensor TMP36
* Optocoupler (I used a LTV-847)
* Dual color LED (You can use separate LEDs if you like)

You can substitute most of these items for anything that is equivalent.

### getting started

* Assemble breadboard
  * Use hardware.fzz or png as a reference
    * [Sample](http://cl.ly/image/2F0Y233C151m)
  * Solder leads on switches from remote
  * Attach Spark Core to breadboard
  * Pins and switches match up to code in arduino

* Setup Spark Core
  * Follow instructions on (Connecting your core)[http://docs.spark.io/#/connect]
  * (Create a new App)[https://www.spark.io/build/new] at spark.io
  * Paste the code from spark_core/remote-start.cpp to this new App
  * Obtain your device_id and access_token from spark.io

* iOS
  * Install Cocoapods
    * cd carspark/iOS
    * pod install
  * Open Carspark.xcworkspace
  * Build and install device on your iPhone or iPod Touch
  * Add Device ID and Access Token in Settings.app or the 'API Settings' button on the Info screen.

### references

Things that will help you learn about how this all works

* [Fritzing](http://fritzing.org/download/) for reading .fzz files
* [Spark Cloud API](https://github.com/spark/docs/blob/master/docs/api.md)

### api

See remote-start.cpp for more info on what api calls can be used.

Events are sent for every api call that is made and if a connection to Spark Cloud is reestablished.

You can subscribe to events like this.

    curl -H "Authorization: Bearer <access_token>" https://api.spark.io/v1/devices/<device_id>/events

### warning

This is a project for myself. I am happy to share what I have done but make no guarantee that anyone else attempting this will enjoy the same success, or failures, that I have.
