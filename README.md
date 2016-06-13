# filey
Build an index of files when idle

1. quit if already running
2. quit if not idle
3. "Shuffle" files
    a. is there a .new file and does it have a processing completed as last line?
       if so, move catalog file to .old and move .new to current
    b. if new exists and no processing completed message then remove it
4. quit if mtime of catalog file indicates it's less than one hour old
5. begin building .new and bail if no longer idle
6. on exit, remove .new and remove lock file

