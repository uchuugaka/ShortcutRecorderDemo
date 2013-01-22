[ShortcutRecorder 2](https://github.com/Kentzo/ShortcutRecorder) Demo
=====================================================================
![ShortcutRecorder Demo](http://wireload.net/uploads/ShortcutRecorder_Demo.png)

This project demonstrates use of ShortcutRecorder and PTHotKey in various situations.
The main window consist of four buttons. The first three buttons shows appropriate demo. The Ping button plays the Ping sound once clicked.

Each of the demo windows represents the same interface which allows you to set two shortcuts:

- Key equivalent of the Ping button on the main window
- Global shortcut to play the Ping sound

Points of Interest
------------------
The following sections covers most interesting parts of the project.

Note that controls on all demo windows are bound to the same keys in NSUserDefaults therefore they are synced among each other.

##IKAppDelegate
It provides actions for buttons, manages the button and global shortcuts.

####-awakeFromNib
Binds the Ping button key equivalent and key equivalent modifier mask to values recorded by the controls. Also observes value of global shortcut in NSUserDefaults and register/unregister it appropriately.

Note use of `SRKeyEquivalentTransformer` and `SRKeyEquivalentModifierMaskTransformer` to properly transform from shortcut to key equivalent and vice versa.

####-observeValueForKeyPath:ofObject:change:context:
Manages global shortcut.

Note that we use `-[PTHotKey hotKeyWithIdentifier:keyCombo:target:action:]` to instantiate PTHotKey.

##IKDemoWindowController
It's the base class for all window controllers used in the demo. It provides basic validation implementation.

####-shortcutRecorder:canRecordShortcut:
Shows how to use SRValidator to check whether shortcut is already taken by other global shortcuts, app's menu items or other shortcut recorders.

Note that we do NSBeep() and present error if shortcut is invalid because SRRecorderControl does nothing.

####-shortcutValidatorShouldUseASCIIStringForKeyCodes:
It returns YES, because Mac OS X always displays locale-independent representation of the shortcut. Otherwise errors generated by SRValidator may contain `⌥Й` instead of `⌥Q`.

##Interface Builder Auto Layout Demo
Demonstrates how easily we can sync control's value with NSUserDefaults by using bindings. Layout is completely done in xib.  

Note the blur effect (Core Animation) and correct drawing of focus rings.

##Code Auto Layout Demo
Like the previous demo, it uses bindings to sync control's value with NSUserDefaults. The main difference is that it sets up UI layout in code using Auto Layout.

Note how we use `NSLayoutFormatAlignAllBaseline` to align labels with controls.

##Interface Builder Autoresizing Masks Demo
Demonstrates that the control properly works with autoresizing masks. Also we do not use bindings here. Instead values are synced in `-shortcutRecorderDidEndRecording:`.

