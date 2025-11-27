<?php

// phpstan-bootstrap.php

// Mock server variables that CodeIgniter needs
$_SERVER['HTTP_HOST'] = 'localhost';
$_SERVER['HTTPS'] = 'off';
$_SERVER['SCRIPT_NAME'] = '/index.php';
$_SERVER['REQUEST_URI'] = '/';
$_SERVER['REMOTE_ADDR'] = '127.0.0.1';

// Define CodeIgniter constants
define('BASEPATH', __DIR__ . '/system/');
define('APPPATH', __DIR__ . '/application/');
define('FCPATH', __DIR__ . '/');
define('VIEWPATH', APPPATH . 'views/');
define('ENVIRONMENT', 'development');

// Prevent CodeIgniter from running fully
// define('STDIN', fopen('php://stdin', 'r'));

// Load only essential files
require_once BASEPATH . 'core/Common.php';
