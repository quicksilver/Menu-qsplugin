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
  return result;
}

- (void)orderOut:(id)sender
{
  if ([self isVisible])
  {
    if([[NSUserDefaults standardUserDefaults] boolForKey:kUseEffects]) [self setFrame:NSOffsetRect([self frame], 0, kMenuBarHeight) alphaValue:0.0 display:NO animate:YES];
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
    if([[NSUserDefaults standardUserDefaults] boolForKey:kUseEffects])
    {
      [fakeMenuWindow mimic];
      [fakeMenuWindow setAlphaValue:1.0];
    }
    NSRect menuScreenRect = [[[NSScreen screens] objectAtIndex:0] frame];
    [self setFrame:NSMakeRect(0, 0, NSWidth(menuScreenRect), NSHeight([self frame])) display:YES animate:NO];
    [self setFrameTopLeftPoint:NSMakePoint(NSMinX(menuScreenRect), NSMaxY(menuScreenRect))];
    if (becomeKey) [super makeKeyAndOrderFront:sender];
    else [super orderFront:sender];
    [self setAlphaValue:1.0];
    if([[NSUserDefaults standardUserDefaults]boolForKey:kUseEffects])
    {
      [fakeMenuWindow setFrame:NSOffsetRect(menuRect(),0,kMenuBarHeight) alphaValue:0.2 display:YES animate:YES];
      [fakeMenuWindow orderOut:sender];
    }
  }
}

- (void)keyDown:(NSEvent *)theEvent
{
  unichar c = [[theEvent characters] characterAtIndex:0];
  if ((c == '\t') || (c == 25) || (c == 27)) [[self delegate] keyDown:theEvent];
  else [super keyDown:theEvent];
}

@end
