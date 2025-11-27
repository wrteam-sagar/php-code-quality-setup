# Laravel Setup

This guide will help you set up pre-commit hooks for your Laravel project to automatically check code quality before each commit.

## Prerequisites

Make sure you have completed the [one-time setup](../README.md#-one-time-setup-run-once) before proceeding.

## Setup Steps

### Step 1: Install Required Packages

Install Laravel Pint and Larastan in your Laravel project:

```bash
composer require laravel/pint --dev
composer require larastan/larastan --dev
```

### Step 2: Download Configuration Files

Download the following configuration files from this folder and place them in the root directory of your Laravel project:

- [`.php-cs-fixer.dist.php`](.php-cs-fixer.dist.php) - PHP CS Fixer configuration
- [`phpmd.xml`](phpmd.xml) - PHPMD (PHP Mess Detector) configuration
- [`phpstan.neon`](phpstan.neon) - PHPStan static analysis configuration
- [`pint.json`](pint.json) - Laravel Pint configuration

**Note:** These files should be placed in your project's root directory (same level as `composer.json`).

### Step 3: Set Up Git Hooks

<!-- 1. Make the pre-commit hook executable:

   ```bash
   sudo chmod +x .git-hooks/pre-commit
   ```

2. Configure Git to use the custom hooks directory:

   ```bash
   git config core.hooksPath .git-hooks
   ``` -->

That's it! Your pre-commit hooks are now configured. Every time you commit code, the hooks will automatically run code quality checks.

## How It Works

When you commit code, the pre-commit hook will:

- Run PHP CS Fixer to check code formatting

```
php-cs-fixer fix
```

- Run PHPMD to detect code mess and potential issues

```
phpmd app,config,database,resources,routes,tests,stubs text phpmd.xml
```

- Run PHPStan/Larastan for static analysis

```
./vendor/bin/phpstan analyse --memory-limit=1G --error-format=table
```

- Run Laravel Pint for code style checks

```
./vendor/bin/pint --config pint.json
```

If any of these checks fail, the commit will be blocked until the issues are resolved.

## Troubleshooting

<!-- ### Hook Not Executing

If the hook doesn't run, verify the configuration:

```bash
# Check if hooks path is set correctly
git config core.hooksPath

# Should output: .git-hooks
```

### Permission Denied

If you get permission errors, ensure the hook is executable:

```bash
chmod +x .git-hooks/pre-commit
``` -->

### Tools Not Found

If the tools are not found, make sure:

1. You've completed the one-time setup
2. Your terminal PATH includes Composer's global bin directory
3. You've restarted your terminal after the one-time setup
