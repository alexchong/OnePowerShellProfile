# OneProfile
Update one PowerShell profile for all installed PS editions (e.g. Desktop, ISE, Core)

## Setup
1. Copy or move `OneProfile` into any location you wish to invoke it
2. In `profile.txt`, replace emptry value in `$ONEPROFILE_PATH` with absolute path of your local `OneProfile/`
3. In `OneProfile.ps1`, replace emptry value in `$ONEPROFILE_PATH` with absolute path of your local `OneProfile/`
4. Navigate to `OneProfile/` path and Run `./OneProfile.ps1` to update all target Current User PowerShell profiles (e.g. Desktop, ISE, Core)
5. Run `. $PROFILE` to update profile in your current shell session

## Features
- [ ] Add toggle to target selected PS edition profiles instead of all
- [ ] Update $ONEPROFILE_PATH to be referenced from one location; OneProfile.ps1 should reference global variable if user profile.txt does not have it
- [ ] Publish v1 module to [PowerShell Gallery](https://www.powershellgallery.com/)
