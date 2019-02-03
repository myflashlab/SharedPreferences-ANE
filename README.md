# Shared Preferences ANE for Android+iOS
If you want to quickly save some information in your AdobeAIR app without having to deal with a database, Using shared preferences ANE can be one of your best choices.

**Main Features:**
* Bringing NSUserDefaults on iOS to AIR
* Bringing SharedPreferences on Android to AIR
* 100% identical AS3 API

[find the latest **asdoc** for this ANE here.](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/sharedPreferences/package-detail.html)

# AIR Usage
For the complete AS3 code usage, see the [demo project here](https://github.com/myflashlab/SharedPreferences-ANE/blob/master/AIR/src/Main.as).

```actionscript
import com.myflashlab.air.extensions.sharedPreferences.*;

SharedPreferences.init();

// save values in different data types using: setString, setBool, setInt, setNumber, setStringArray
SharedPreferences.setString("key", "value");

// you can read back values with the specified data types like how you set them before.
var value:String = SharedPreferences.getString("key");

// you can read all available data in an object
var obj:Object = SharedPreferences.getAll();

// you can delete a key/value paid
SharedPreferences.remove("key");

// or clear the whole thing!
SharedPreferences.clear();

// For better performance, the ANE is caching the values. You can always refresh the cache 
SharedPreferences.refreshCache();
```

# Air .xml manifest
```xml
<!--
Embedding the ANE:
-->
  <extensions>
	<extensionID>com.myflashlab.air.extensions.sharedPreferences</extensionID>
	
	<!-- dependency ANEs https://github.com/myflashlab/common-dependencies-ANE -->
	<extensionID>com.myflashlab.air.extensions.dependency.overrideAir</extensionID>
  </extensions>
-->
```

# Requirements
* Android API 19+
* iOS SDK 8.0+
* AIR SDK 31.0+

# Tutorials
[How to embed ANEs into **FlashBuilder**, **FlashCC** and **FlashDevelop**](https://www.youtube.com/watch?v=Oubsb_3F3ec&list=PL_mmSjScdnxnSDTMYb1iDX4LemhIJrt1O)  

# Premium Support #
[![Premium Support package](https://www.myflashlabs.com/wp-content/uploads/2016/06/professional-support.jpg)](https://www.myflashlabs.com/product/myflashlabs-support/)
If you are an [active MyFlashLabs club member](https://www.myflashlabs.com/product/myflashlabs-club-membership/), you will have access to our private and secure support ticket system for all our ANEs. Even if you are not a member, you can still receive premium help if you purchase the [premium support package](https://www.myflashlabs.com/product/myflashlabs-support/).