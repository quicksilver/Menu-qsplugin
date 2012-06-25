#import "QSFakeMenuWindow.h"

@interface QSMenuWindow : NSPanel
{
  bool hidden;
  QSFakeMenuWindow *fakeMenuWindow;
}

- (BOOL)canBecomeKeyWindow;
- (BOOL)canBecomeMainWindow;
- (NSTimeInterval)animationResizeTime:(NSRect)newFrame;
- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag;
- (void)orderOut:(id)sender;
- (void)makeKeyAndOrderFront:(id)sender;
- (void)orderFront:(id)sender;
- (void)orderFront:(id)sender makeKey:(BOOL)becomeKey;
- (void)keyDown:(NSEvent *)theEvent;

@end
