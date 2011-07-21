NSRect menuRect();

@interface QSFakeMenuWindow : NSWindow

- (id)init;
- (void)mimic;
- (NSTimeInterval)animationResizeTime:(NSRect)newFrame;
- (NSImage *)menuBarImage;

@end
