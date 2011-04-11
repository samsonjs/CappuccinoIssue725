/*
 * AppController.j
 * CappuccinoIssue725
 *
 * Created by You on June 16, 2010.
 * Copyright 2010, Your Company All rights reserved.
 */

@import <Foundation/Foundation.j>

CPLogRegister(CPLogConsole);

@implementation Node : CPObject
{
    CPString title @accessors;
    CPArray children @accessors;
}
- (id) initWithTitle: (CPString)aTitle children: someChildren
{
    self = [super init];
    if (self) {
        title = aTitle;
        children = someChildren;
    }
    return self;
}
@end


@implementation AppController : CPObject
{
    CPOutlineView ov;
    CPNumber selectedRow;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];

    ov = [[CPOutlineView alloc] initWithFrame: CGRectMake(0, 0, 300, 800)];
    [ov setDelegate: self];
    [ov setDataSource: self];
    [ov setAutoresizingMask: CPViewHeightSizable];

    var column = [[CPTableColumn alloc] initWithIdentifier: @"Title"];
    [ov addTableColumn: column];
    [ov setOutlineTableColumn: column];

    [contentView addSubview:ov];
    

    [theWindow orderFront:self];

    // Uncomment the following line to turn on the standard menu bar.
    //[CPMenu setMenuBarVisible:YES];
}

- (id) outlineView: (CPOutlineView)_ child: (int)n ofItem: (id)item
{
    if (item) return [item children][n];

    var children = [],
        i = 1;
    for (; i < 6; ++i)
        [children addObject: [[Node alloc] initWithTitle: 'Child #' + i children: []]];
    return [[Node alloc] initWithTitle: 'Item #' + (n+1) children: children];
}

- (BOOL) outlineView: (CPOutlineView)_ isItemExpandable: (id)item
{
    return item === nil || [[item children] count] > 0;
}

- (int) outlineView: (CPOutlineView)_ numberOfChildrenOfItem: (id)item
{
    return item ? [[item children] count] : 3;
}

- (id) outlineView: (CPOutlineView)_ objectValueForTableColumn: (CPTableViewColumn)column byItem: (id)item
{
    return [item title];
}

- (void) outlineViewItemWillExpand: (CPNotification)aNotification
{
    if ([ov rowForItem: item] < [ov selectedRow]) {
        var item = [[aNotification userInfo] objectForKey: @"CPObject"];
        selectedRow += [[item children] count];
    }
}

- (void) outlineViewItemDidExpand: (CPNotification)aNotification
{
    if (selectedRow !== [ov selectedRow])
        [ov selectRowIndexes: [CPIndexSet indexSetWithIndex: selectedRow] byExtendingSelection: NO];
}

- (void) outlineViewItemWillCollapse: (CPNotification)aNotification
{
    if ([ov rowForItem: item] < [ov selectedRow]) {
        var item = [[aNotification userInfo] objectForKey: @"CPObject"];
        selectedRow -= [[item children] count];
    }
}

- (void) outlineViewItemDidCollapse: (CPNotification)aNotification
{
    [ov selectRowIndexes: [CPIndexSet indexSetWithIndex: selectedRow] byExtendingSelection: NO];
}

- (void) outlineViewSelectionDidChange: (CPNotification)aNotification
{
    selectedRow = [ov selectedRow];
}

@end
