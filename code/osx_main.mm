// osx_main.mm
//
// The entry point to handmade hero

#import <stdio.h>
#include <AppKit/AppKit.h>

int main (int argc, const char * argv[]){
    
    // ALLOCATE a window and show it
    while(true){
      NSEvent* event;
      do {
        event = [
          NSApp nextEventMatchingMask: NSEventMaskAny
          untilDate: nil
          inMode: NSDefaultRunLoopMode
          dequeue: YES
        ];
        switch([event type]){
          default:
            [NSApp sendEvent: event];
        }
      }

      while(event != nil);
    }

    printf("Handmade Hero app");

}