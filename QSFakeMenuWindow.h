#define kQSMenuInterfaceType @"QSMenuInterfaceType"
#define kMenuBarHeight 22.0f

NSRect menuRect();

@interface QSFakeMenuWindow : NSWindow

- (id)init;
- (void)mimic;
- (NSTimeInterval)animationResizeTime:(NSRect)newFrame;
- (NSImage *)menuBarImage;

@end
