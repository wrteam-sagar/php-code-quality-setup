#!/usr/bin/env bash

set -e

echo ""
echo "=========================================="
echo "  VSCode Environment Setup"
echo "=========================================="
echo ""

# -------------------
# IDE Extension Installations
# -------------------
ACTIVE_PROFILE="Default"

# Array of extensions to install
EXTENSIONS=(
    "bmewburn.vscode-intelephense-client"
    "mehedidracula.php-namespace-resolver"
    "xdebug.php-debug"
    "editorconfig.editorconfig"
    "DEVSENSE.phptools-vscode"
    "amiralizadeh9480.laravel-extra-intellisense"
    "onecentlin.laravel-blade"
    "shufo.vscode-blade-formatter"
    "formulahendry.auto-rename-tag"
    "oderwat.indent-rainbow"
    "valeryanm.vscode-phpsab"
    "junstyle.php-cs-fixer"
    "ecodes.vscode-phpmd"
    "sanderronde.phpstan-vscode"
)

# Function to install extensions for a given IDE command
install_extensions() {
    local ide_cmd=$1
    local ide_name=$2
    
    echo ""
    echo "Installing $ide_name Extensions..."
    
    if ! command -v "$ide_cmd" &> /dev/null; then
        echo "$ide_name not detected. Skipping $ide_name extension installation."
        return
    fi
    
    # Track installation results
    local success_count=0
    local failed_count=0
    local skipped_count=0
    local total=${#EXTENSIONS[@]}
    
    # Install extensions one by one to continue even if one fails
    for extension in "${EXTENSIONS[@]}"; do
        # Skip commented extensions (lines starting with #)
        if [[ "$extension" =~ ^[[:space:]]*# ]]; then
            skipped_count=$((skipped_count + 1))
            continue
        fi
        
        # Remove any leading/trailing whitespace
        extension=$(echo "$extension" | xargs)
        
        # Skip empty entries
        if [ -z "$extension" ]; then
            skipped_count=$((skipped_count + 1))
            continue
        fi
        
        # Try to install extension, but continue even if it fails
        # Use set +e temporarily to allow errors without stopping script
        set +e
        if $ide_cmd --profile "$ACTIVE_PROFILE" --force --install-extension "$extension" > /dev/null 2>&1; then
            success_count=$((success_count + 1))
            echo "  ✅ Installed: $extension"
        else
            failed_count=$((failed_count + 1))
            echo "  ❌ Failed: $extension (may not be available in $ide_name marketplace)"
        fi
        set -e
    done
    
    echo ""
    echo "📊 $ide_name installation summary:"
    echo "   ✅ Success: $success_count"
    if [ $failed_count -gt 0 ]; then
        echo "   ❌ Failed: $failed_count"
    fi
    if [ $skipped_count -gt 0 ]; then
        echo "   ⏭️  Skipped: $skipped_count"
    fi
    echo ""
}

# Install extensions for VSCode
install_extensions "code" "VSCode"

# Install extensions for Cursor (if available)
install_extensions "cursor" "Cursor"

# -------------------
# Detect Operating System
# -------------------
# Detect OS and set appropriate paths for IDE settings
detect_os() {
    case "$(uname -s)" in
        Darwin*)
            OS="mac"
            VSCODE_SETTINGS_PATH="$HOME/Library/Application Support/Code/User/settings.json"
            CURSOR_SETTINGS_PATH="$HOME/Library/Application Support/Cursor/User/settings.json"
            ;;
        Linux*)
            OS="linux"
            VSCODE_SETTINGS_PATH="$HOME/.config/Code/User/settings.json"
            CURSOR_SETTINGS_PATH="$HOME/.config/Cursor/User/settings.json"
            ;;
        CYGWIN*|MINGW32*|MSYS*|MINGW*)
            OS="windows"
            # Windows paths using APPDATA environment variable
            if [ -n "$APPDATA" ]; then
                VSCODE_SETTINGS_PATH="$APPDATA/Code/User/settings.json"
                CURSOR_SETTINGS_PATH="$APPDATA/Cursor/User/settings.json"
            else
                # Fallback if APPDATA is not set
                VSCODE_SETTINGS_PATH="$HOME/AppData/Roaming/Code/User/settings.json"
                CURSOR_SETTINGS_PATH="$HOME/AppData/Roaming/Cursor/User/settings.json"
            fi
            ;;
        *)
            OS="unknown"
            # Default to Linux paths as fallback
            VSCODE_SETTINGS_PATH="$HOME/.config/Code/User/settings.json"
            CURSOR_SETTINGS_PATH="$HOME/.config/Cursor/User/settings.json"
            echo "Warning: Unknown OS detected. Using Linux paths as fallback."
            ;;
    esac
}

# Detect OS and set paths
detect_os

# -------------------
# Apply Default Settings
# -------------------
# Function to apply settings to an IDE
apply_settings() {
    local settings_path=$1
    local ide_name=$2
    
    # Check if IDE is installed by checking if settings directory exists or command exists
    local ide_installed=false
    if [ -d "$(dirname "$settings_path")" ] || command -v "$(echo "$ide_name" | tr '[:upper:]' '[:lower:]')" &> /dev/null; then
        ide_installed=true
    fi
    
    if [ "$ide_installed" = false ]; then
        echo "$ide_name not detected. Skipping $ide_name settings configuration."
        return
    fi
    
    # Create directory if it doesn't exist
    mkdir -p "$(dirname "$settings_path")"
    
    # Apply settings
    cat > "$settings_path" << 'EOF'
{
    "editor.formatOnSave": true,
    "phpsab.standard": "PSR12",
    "phpstan.enabled": true,
    "[php]": {
        "editor.defaultFormatter": "junstyle.php-cs-fixer"
    },
    "phpsab.debug": true,
    "php-cs-fixer.onsave": true,
    "php-cs-fixer.executablePath": "php-cs-fixer",
    "php-cs-fixer.executablePathWindows": "",
    "php-cs-fixer.rules": {
        "@PSR12": true,
        "braces_position": {
            "classes_opening_brace": "same_line",
            "functions_opening_brace": "same_line"
        }
    },
    "php-cs-fixer.config": ".php-cs-fixer.php;.php-cs-fixer.dist.php;.php_cs;.php_cs.dist",
    "php-cs-fixer.pathMode": "override",
    "php-cs-fixer.exclude": [],
    "php-cs-fixer.autoFixByBracket": true,
    "php-cs-fixer.autoFixBySemicolon": false,
    "php-cs-fixer.formatHtml": false,
    "php-cs-fixer.documentFormattingProvider": true,
    "php-cs-fixer.ignorePHPVersion": false,
    "phpmd.verbose": true,
    "phpmd.command": "phpmd",
    "phpstan.checkValidity": true,
    "phpstan.showProgress": true,
    "diffEditor.ignoreTrimWhitespace": false,
    "diffEditor.hideUnchangedRegions.enabled": true,
    "git.enableSmartCommit": true,
    "prettier.bracketSameLine": true,
    "php.format.rules.indentBraces": false,
    "intelephense.format.braces": "k&r",
    "phpsab.fixerEnable": false,
    "phpsab.snifferArguments": [
        "--sniffs=Squiz.WhiteSpace.ScopeOpeningBrace",
        "--runtime-set scope_opening_brace_indent 0",
        "--runtime-set scope_opening_brace_newline false"
    ]
}
EOF
    
    echo "✅ $ide_name settings configured at: $settings_path"
}

echo ""
echo "Applying IDE settings..."

# Apply settings to VSCode
apply_settings "$VSCODE_SETTINGS_PATH" "VSCode"

# Apply settings to Cursor
apply_settings "$CURSOR_SETTINGS_PATH" "Cursor"

echo ""

# Detect OS home composer bin path
if [ -d "$HOME/.composer/vendor/bin" ]; then
    COMPOSER_BIN="$HOME/.composer/vendor/bin"
elif [ -d "$HOME/.config/composer/vendor/bin" ]; then
    COMPOSER_BIN="$HOME/.config/composer/vendor/bin"
else
    COMPOSER_BIN="$HOME/.composer/vendor/bin"
fi

# -------------------
# Composer Installation
# -------------------
if ! command -v composer &> /dev/null; then
    echo "Composer not found. Installing..."
    EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
    php -r "copy('https://getcomposer.org/installer','composer-setup.php');"
    php -r "if (hash_file('sha384','composer-setup.php') !== '$EXPECTED_SIGNATURE') { echo 'Installer corrupt'; unlink('composer-setup.php'); exit(1); }"
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer
    rm composer-setup.php
else
    echo "Composer already installed."
fi

# -------------------
# Install Global PHP Tools
# -------------------
echo ""
echo "Installing Global PHP Developer Tools..."
composer global require squizlabs/php_codesniffer friendsofphp/php-cs-fixer phpstan/phpstan laravel/pint phpmd/phpmd larastan/larastan

# Ensure PATH contains composer global bin
SHELL_RC="$HOME/.bashrc"
if [[ $SHELL == *"zsh"* ]]; then SHELL_RC="$HOME/.zshrc"; fi

if [[ ":$PATH:" != *":$COMPOSER_BIN:"* ]]; then
    echo "export PATH=\$PATH:$COMPOSER_BIN" >> "$SHELL_RC"
    echo "Added Composer global bin to PATH. Restart terminal to apply."
fi

# -------------------
# Xdebug Instructions
# -------------------
# echo ""
# echo "To enable debugging, add this to php.ini:"
# echo ""
# echo "zend_extension=xdebug.so"
# echo "xdebug.mode=debug"
# echo "xdebug.start_with_request=yes"
# echo "xdebug.client_host=127.0.0.1"
# echo "xdebug.client_port=9003"
# echo ""
# echo "Then in VSCode, Debug → 'Listen for Xdebug'."
# echo ""

echo "✅ Setup Complete. Restart terminal and your IDE(s)."
echo ""
