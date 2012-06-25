
@class QSMenuButton;

@interface QSMenuInterfaceController : QSInterfaceController

- (id)init;
- (void)windowDidLoad;
- (void)updateViewLocations;
- (NSSize)maxIconSize;
- (NSRect)window:(NSWindow *)window willPositionSheet:(NSWindow *)sheet usingRect:(NSRect)rect;

@end
