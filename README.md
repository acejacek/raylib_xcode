# Xcode Template for Raylib Projects

This is a simple project template for usage within Xcode. It simplifies the steeps needed to perform when starting new project. For details, see [Working on macOS](https://github.com/raysan5/raylib/wiki/Working-on-macOS) from official raylib documentation.

## Prerequisite

Install raylib with Homebrew method
- if [Homebrew](https://brew.sh) is not installed, run:
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
- install raylib:
```
brew install raylib
```

## Instalation of Xcode project template

### Manual installation
Create folder, preferably in user's local library:

```
mkdir -p ~/Library/Developer/Xcode/Templates/Project\ Templates/Raylib/Raylib.xctemplate/
```

Copy all files fom this repo into this folder.

From now on, when creating new project, it's possible to select raylib (in macOS platform, scroll down to see it at the bottom of the list). Such created new project will have a link to `libraylib.a` and pre-set search paths to headers and library files. Additionally, it will disable library validations, preventing linking the unsigned raylib.

### Scripted installation

Too lazy to manually install the template? Copy and paste these lines into your terminal and let your computer take care of everything!
```
mkdir -p ~/Library/Developer/Xcode/Templates/Project\ Templates/Raylib/Raylib.xctemplate/
cd ~/Library/Developer/Xcode/Templates/Project\ Templates/Raylib/Raylib.xctemplate/
wget https://github.com/acejacek/raylib_xcode/archive/main.zip
unzip -j raylib_xcode-main.zip
rm https://github.com/acejacek/raylib_xcode/archive/main.zip
```
