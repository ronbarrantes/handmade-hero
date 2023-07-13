// osx_main.mm
//
// The entry point to handmade hero

#import <stdio.h>
#include <AppKit/AppKit.h>

static float GlobalRenderingWidth = 1024;
static float GlobalRenderingHeight = 768;
static bool Running = true;

@interface HandmadeWindowDelegate: NSObject<NSWindowDelegate>
@end

@implementation HandmadeWindowDelegate

- (void)windowWillClose:(NSNotification *)notification {
  Running = false;
}

@end

int main (int argc, const char * argv[]){
  HandmadeWindowDelegate *mainWindowDelegate = [[HandmadeWindowDelegate alloc] init];
  NSRect screenRect = [[NSScreen mainScreen] frame];
  NSRect windowRect = NSMakeRect(
      (screenRect.size.width - GlobalRenderingWidth) / 2,
      (screenRect.size.height - GlobalRenderingHeight) / 2,
      GlobalRenderingWidth,
      GlobalRenderingHeight
    );

  NSWindow *window = [[NSWindow alloc]
      initWithContentRect: windowRect
      styleMask:  NSWindowStyleMaskTitled |
                  NSWindowStyleMaskClosable |
                  NSWindowStyleMaskMiniaturizable |
                  NSWindowStyleMaskResizable
      backing: NSBackingStoreBuffered
      defer: NO];

  [window setBackgroundColor: NSColor.magentaColor];
  [window setTitle: @"Handmade Hero"];
  [window makeKeyAndOrderFront: nil];
  [window setDelegate: mainWindowDelegate];

  int bitmapWidth = window.contentView.bounds.size.width;
  int bitmapHeight = window.contentView.bounds.size.height;
  int bytesPerPixel = 4;
  // Size of row
  int pitch = bitmapWidth * bytesPerPixel;
  uint8_t *buffer = (uint8_t*)malloc(pitch * bitmapHeight);

  // Pixel element
  uint8_t red = 255;
  uint8_t green = 0;
  uint8_t blue = 0;
  uint8_t alpha = 255; // may need be 100


  NSBitmapImageRep *rep = [[NSBitmapImageRep alloc]
                              initWithBitmapDataPlanes: &buffer
                              pixelsWide: bitmapWidth
                              pixelsHigh: bitmapHeight
                              bitsPerSample: sizeof(&red) // should be 8
                              samplesPerPixel: bytesPerPixel
                              hasAlpha: YES
                              isPlanar: NO
                              colorSpaceName: NSDeviceRGBColorSpace
                              bytesPerRow: pitch
                              bitsPerPixel: 32
                            ];
   

  NSSize imageSize = NSMakeSize(bitmapWidth, bitmapHeight);
  NSImage *image = [[NSImage alloc] initWithSize: imageSize];
  [image addRepresentation: rep];
  window.contentView.layer.contents = image;

  // ALLOCATE a window and show it
  while(Running){
    NSEvent* event;
    do {
      event = [NSApp nextEventMatchingMask: NSEventMaskAny
        untilDate: nil
        inMode: NSDefaultRunLoopMode
        dequeue: YES];
      switch([event type]){
        default:
          [NSApp sendEvent: event];
      }
    }

    while(event != nil);
  }

  printf("Handmade finished running\n");
}
