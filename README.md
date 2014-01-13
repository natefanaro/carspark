carspark
========

remote start -> spark core -> mifi -> internet <- iphone

### about this project

I started this project to get remote start working on my car from my iPhone. Much like Viper SmartStart or CompuStar’s Drone Mobile.

### disclaimer

This is a project for myself. I am happy to share what I have done but make no guarantee that anyone else attempting this will enjoy the same success, or failures, that I have.

### current features

* Simple API
  * All calls to the Spark Core can be done through a REST call. This gives me the option to make anything that has an internet connection a remote. Ideas include my TiVo and Pebble watch.
* iOS Client
  * Screenshots
    * http://cl.ly/1z3i0g3I2X1M
    * http://cl.ly/1u2e3W1Z1b3h
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
* Temperature Sensor LM34DZ
* Optocoupler (I used a LTV-847)
* Dual color LED (You can use separate LEDs if you like)

You can substitute these items for anything that is equivalent. Arduino code has some specifics for the Spark Core’s API but really you just need an Arduino that can have an always on connection to the internet.

### getting started

* Assemble breadboard
  * Use hardware.fzz or png as a reference
  * Solder leads on switches from remote
  * Attach Spark Core to breadboard
  * Pins and switches match up to code in arduno/

* Setup Spark Core
  * Follow instructions on (Connecting your core)[http://docs.spark.io/#/connect]
  * (Create a new App)[https://www.spark.io/build/new] at spark.io
  * Paste the code from arduino/the_user_app.cpp to this new App
  * Obtain your device_id and access_token from spark.io

* iOS
  * Install Cocoapods
    * cd carspark/iOS
    * pod install
  * Open Carspark.xcworkspace
  * Add device_id and access_token to iOS/Carspark/SparkCom.m
  * Build and install device on your iPhone or iPod Touch

### references

Things that will help you learn about how this all works

* [Fritzing](http://fritzing.org/download/) for reading .fzz files
* [Spark Cloud API](https://github.com/spark/docs/blob/master/docs/api.md)
