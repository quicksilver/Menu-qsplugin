#import "QSMenuWindow.h"
#import <QSFoundation/QSFoundation.h>

@implementation QSMenuWindow

- (BOOL)canBecomeKeyWindow
{
  return YES;
}

- (BOOL)canBecomeMainWindow
{
  return YES;
}

- (NSTimeInterval)animationResizeTime:(NSRect)newFrame
{
  return 0.1;
}

- (id)initWithContentRect:(NSRect)contentRect styleMask:(unsigned int)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
  NSWindow *result = [super initWithContentRect:contentRect styleMask:NSNonactivatingPanelMask|NSBorderlessWindowMask backing:bufferingType defer:NO];
  [self setBackgroundColor:[NSColor clearColor]];
  [self setOpaque:NO];
  [self setHasShadow:NO];
  [self setLevel:25];
  hidden = YES;
  fakeMenuWindow = [[QSFakeMenuWindow alloc] init];
  return (QSMenuWindow *)result;
}

- (void)orderOut:(id)sender
{
  if ([self isVisible])
  {
    [super orderOut:sender];
  }
}

- (void)makeKeyAndOrderFront:(id)sender
{
  [self orderFront:self makeKey:YES];
}

- (void)orderFront:(id)sender
{
  [self orderFront:self makeKey:NO];
}

- (void)orderFront:(id)sender makeKey:(BOOL)becomeKey
{
  if (![self isVisible])
  {
    NSRect menuScreenRect = [[[NSScreen screens] objectAtIndex:0] frame];
    [self setFrame:NSMakeRect(0, 0, NSWidth(menuScreenRect), NSHeight([self frame])) display:YES animate:NO];
    [self setFrameTopLeftPoint:NSMakePoint(NSMinX(menuScreenRect), NSMaxY(menuScreenRect))];
      if (becomeKey) {
          [super makeKeyAndOrderFront:sender];
      }
      else {
          [super orderFront:sender];
      }
      [self setAlphaValue:1.0];
    }
}

- (void)keyDown:(NSEvent *)theEvent
{
  unichar c = [[theEvent characters] characterAtIndex:0];
  if ((c == '\t') || (c == 25) || (c == 27)) [[self delegate] keyDown:theEvent];
  else [super keyDown:theEvent];
}

@end
