//
//  IKIBAutoresizingMasksWindowController.m
//  ShortcutRecorderDemo
//
//  Created by Ilya Kulakov on 20.01.13.
//  Copyright (c) 2013 Ilya Kulakov. All rights reserved.
//

#import "IKIBAutoresizingMasksWindowController.h"


@implementation IKIBAutoresizingMasksWindowController

- (void)dealloc
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObserver:self forKeyPath:@"ping"];
    [defaults removeObserver:self forKeyPath:@"globalPing"];
}


#pragma mark SRRecorderControlDelegate

- (void)shortcutRecorderDidEndRecording:(SRRecorderControl *)aRecorder
{
    if (aRecorder == self.pingShortcutRecorder)
        [[NSUserDefaults standardUserDefaults] setValue:aRecorder.objectValue forKey:@"ping"];
    else if (aRecorder == self.globalPingShortcutRecorder)
        [[NSUserDefaults standardUserDefaults] setValue:aRecorder.objectValue forKey:@"globalPing"];
}


#pragma mark NSObject

- (void)awakeFromNib
{
    [super awakeFromNib];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults addObserver:self forKeyPath:@"ping" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:NULL];
    [defaults addObserver:self forKeyPath:@"globalPing" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)aKeyPath ofObject:(id)anObject change:(NSDictionary *)aChange context:(void *)aContext
{
    if ([aKeyPath isEqualToString:@"ping"])
        self.pingShortcutRecorder.objectValue = aChange[NSKeyValueChangeNewKey];
    else if ([aKeyPath isEqualToString:@"globalPing"])
        self.globalPingShortcutRecorder.objectValue = aChange[NSKeyValueChangeNewKey];
    else
        [super observeValueForKeyPath:aKeyPath ofObject:anObject change:aChange context:aContext];
}

@end
