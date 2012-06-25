#import "QSMenuInterfaceController.h"
#import <Carbon/Carbon.h>
#import <IOKit/IOCFBundle.h>
#import <ApplicationServices/ApplicationServices.h>

@implementation QSMenuInterfaceController

- (id)init
{
  if (!(self = [self initWithWindowNibName:@"MenuInterface"])) return nil;
  return self;
}

- (void)windowDidLoad
{
  [super windowDidLoad];
  [menuButton setMenuOffset:NSMakePoint(0.0,1.0)];
	[[self window] setOpaque:YES];
	[[[self window] contentView] setDepth:1.5];
	[[self menuButton] setDrawBackground:YES];
	
    NSArray *selectors = [NSArray arrayWithObjects:dSelector,aSelector,iSelector,nil];
    for (QSSearchObjectView *individualSelector in selectors) {
        [[individualSelector cell] setBezeled:YES];
        [[individualSelector cell] setShowDetails:NO];
        [[individualSelector cell] setTextColor:[NSColor blackColor]];
        [[individualSelector cell] setNameFont:[NSFont systemFontOfSize:11.0f]];
        [individualSelector setTextCellFont:[NSFont systemFontOfSize:11.0f]];
        [individualSelector setPreferredEdge:NSMinYEdge];
        [individualSelector setResultsPadding:1];
 
    }



  [self updateViewLocations];
}

- (void)updateViewLocations
{
  [super updateViewLocations];
  
  NSRect dFrame = [dSelector frame];
  NSRect aFrame = [aSelector frame];
  NSRect iFrame = [iSelector frame];
  dFrame.size.width = MIN(256, (NSInteger)[[dSelector cell] cellSize].width);
  aFrame.size.width = MIN(256, (NSInteger)[[aSelector cell] cellSize].width);
  iFrame.size.width = MIN(256, (NSInteger)[[iSelector cell] cellSize].width);
  aFrame.origin.x = NSMaxX(dFrame) + 4;
  iFrame.origin.x = NSMaxX(aFrame) + 4;
  [dSelector setFrame:dFrame];
  [aSelector setFrame:aFrame];
  [iSelector setFrame:iFrame];
  [[[self window] contentView] setNeedsDisplay:YES];
}

- (NSSize)maxIconSize
{
  return NSMakeSize(32,32);
}

- (NSRect)window:(NSWindow *)window willPositionSheet:(NSWindow *)sheet usingRect:(NSRect)rect
{
  return NSOffsetRect(rect, 0, -NSHeight([window frame]));
}

@end


