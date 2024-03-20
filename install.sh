#!/bin/bash

set -e

get_raylib_paths() {
  # Function to get raylib paths, either the found version or user input
  local version_path="$1"

  if [ -d "$version_path" ]; then
    echo "Raylib version directory '$version_path' found."
    read -p "Is this the correct version of Raylib you want to use? (y/n) " yn
    case $yn in
        [Yy]* ) echo "Using detected Raylib version at: $version_path";;
        [Nn]* )
          read -p "Enter the Raylib library path: " custom_lib_path
          read -p "Enter the Raylib include path: " custom_include_path
          LIB_PATH=$custom_lib_path
          HEADER_PATH=$custom_include_path
          return;;
        * ) echo "Please answer yes or no."; get_raylib_paths $version_path;;
    esac
  else
    echo "$version_path not found. Please specify the custom paths."
    read -p "Enter the Raylib library path: " custom_lib_path
    read -p "Enter the Raylib include path: " custom_include_path
    LIB_PATH=$custom_lib_path
    HEADER_PATH=$custom_include_path
    return
  fi

  LIB_PATH="$version_path/lib"
  HEADER_PATH="$version_path/include/**"
}

TEMPLATE_DIR="${HOME}/Library/Developer/Xcode/Templates/Project Templates/Raylib/Raylib.xctemplate"

RAYLIB_HOMEBREW_PATH=$(brew --cellar raylib)
RAYLIB_DEFAULT_VERSION="5.0"
RAYLIB_PATH="$RAYLIB_HOMEBREW_PATH/$RAYLIB_DEFAULT_VERSION"

get_raylib_paths "$RAYLIB_PATH"

PLIST_CONTENT=$(cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Identifier</key>
	<string>com.raylib.app</string>
	<key>Concrete</key>
	<true/>
	<key>Description</key>
	<string>This template creates a raylib project. </string>
	<key>Options</key>
	<array>
		<dict>
			<key>Identifier</key>
			<string>languageChoice</string>
			<key>Default</key>
			<string>C</string>
			<key>Values</key>
			<array>
				<string>C</string>
			</array>
			<key>Variables</key>
			<dict/>
			<key>Units</key>
			<dict/>
		</dict>
	</array>
	<key>Kind</key>
	<string>Xcode.Xcode3.ProjectTemplateUnitKind</string>
	<key>Ancestors</key>
	<array>
		<string>com.apple.dt.unit.commandLineTool</string>
	</array>
	<key>Nodes</key>
	<array>
		<string>raylib.entitlements</string>
		<string>main.c</string>
		<string>libraylib.a</string>
	</array>
	<key>Definitions</key>
	<dict>
		<key>libraylib.a</key>
		<dict>
			<key>PathType</key>
			<string>Absolute</string>
			<key>Path</key>
			<string>${LIB_PATH}/libraylib.a</string>
		</dict>
		<key>main.c</key>
		<dict>
			<key>Path</key>
			<string>main.c</string>
		</dict>
		<key>raylib.entitlements</key>
		<dict>
			<key>Path</key>
			<string>raylib.entitlements</string>
		</dict>
	</dict>
	<key>Project</key>
	<dict>
		<key>SharedSettings</key>
		<dict>
			<key>LIBRARY_SEARCH_PATHS</key>
			<string>${LIB_PATH}</string>
			<key>HEADER_SEARCH_PATHS</key>
			<string>${HEADER_PATH}</string>
			<key>CODE_SIGN_ENTITLEMENTS</key>
			<string>___PACKAGENAME___/raylib.entitlements</string>
		</dict>
	</dict>
</dict>
</plist>
EOF
)

mkdir -p "${TEMPLATE_DIR}"
echo "${PLIST_CONTENT}" > "TemplateInfo.plist"

rsync -av --exclude='install.sh' --exclude='.git' --exclude='.gitignore' ./ "${TEMPLATE_DIR}/"

echo "Raylib Xcode project template done."
