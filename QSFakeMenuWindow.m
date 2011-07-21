#import "QSFakeMenuWindow.h"

NSRect menuRect()
{
  NSRect menuRect = [[[NSScreen screens] objectAtIndex:0] frame];
  float yOffset = NSHeight(menuRect) - kMenuBarHeight;
  menuRect.size.height = kMenuBarHeight;
  menuRect = NSOffsetRect(menuRect ,0 ,yOffset);
  return menuRect;
}

@implementation QSFakeMenuWindow

- (id)init
{
  NSWindow *result = [super initWithContentRect:menuRect() styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:YES];
  [self setBackgroundColor:[NSColor clearColor]];
  [self setOpaque:NO];
  [self setHasShadow:NO];
  [self setLevel:27];
  [self setMovableByWindowBackground:YES];
  
  NSImageView *content = [[NSImageView alloc] initWithFrame:NSZeroRect];
  [content setImageFrameStyle:NSImageFrameNone];
  [content setImageScaling:NSScaleNone];
  [self setContentView:content];
  
  return result;
}

- (void)mimic
{
  [self orderOut:self];
  [[self contentView] setImage:[self menuBarImage]];
  [self setLevel:NSPopUpMenuWindowLevel];
  [self orderWindow:NSWindowAbove relativeTo:0];
  [self orderFront:self];
  [self setFrame:menuRect() display:YES animate:NO];
}

- (NSTimeInterval)animationResizeTime:(NSRect)newFrame
{
  return 0.1;
}

- (NSImage *)menuBarImage
{
  CGRect rect = {CGPointZero, {CGDisplayPixelsWide(kCGDirectMainDisplay), kMenuBarHeight}};
  CGImageRef windowImage = CGWindowListCreateImage(rect, kCGWindowListOptionOnScreenOnly, kCGNullWindowID, 0);
  NSImage *menuBarImage = nil;
  if (windowImage)
  {
    NSBitmapImageRep *rep = [[NSBitmapImageRep alloc] initWithCGImage:windowImage];
    CGImageRelease(windowImage);
    menuBarImage = [[[NSImage alloc] init] autorelease];
    [menuBarImage addRepresentation:rep];
    [rep release];
  }
  return menuBarImage;
}

@end

