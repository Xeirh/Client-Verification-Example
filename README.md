# Client-Verification-Example
Custom system example that will auto switch from player guid check to non guid check for custom servers or private match. Has auto verify also, so if enabled and anyone that joins will be automatically given access.

- level.guid_list
  - This is the variable that stores the array to check your or multiple guids for verification.

- level.guid_verify
  - You won't have to mess with this as it uses the built in variable for ranked match to auto switch the verification system for servers and private match.
    - Example client custom servers use the level.rankedmatch
    - Will also work on the retail titles if using rpc to force an online session, but this is intended for clients.

- level.auto_verify
  - This will auto verify players that join during the duration of this variable being enabled.

- level.debug_leave
  - If session if private match and enabled this will auto exit level saving you some sweet juicy time.
