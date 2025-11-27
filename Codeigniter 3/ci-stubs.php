<?php

// ci-stubs.php

class CI_Controller {
    public $load;
    public $db;
    public $input;
    public $session;
    public $form_validation;
    public $uri;
    public $config;
    public $output;
    public $security;
    public $upload;
    public $email;
    public $pagination;
    public $cart;
    public $user_agent;
    public $encryption;
    public $image_lib;
    public $zip;
    public $ftp;
    public $xmlrpc;
    public $table;
    public $calendar;
    public $unit_test;
    public $parser;
    public $trackback;
    public $typography;
    public $benchmark;
    public function __construct() {
    }

    public function post($key = null | string, $xss_clean = null | bool) {
    }
}

class CI_Model {
    public $db;
    public $load;
    public $input;
    public $session;
    public $config;
    public $security;
    public $form_validation;
    public $upload;

    public function __get($key) {
        return get_instance()->$key;
    }
}

class CI_Loader {
    public function model($model, $name = '', $db_conn = false) {
    }
    public function view($view, $vars = [], $return = false) {
    }
    public function helper($helpers = []) {
    }
    public function library($library = '', $params = null, $object_name = null) {
    }
    public function database($params = '', $return = false, $query_builder = null) {
    }
    public function vars($vars = [], $val = '') {
    }
}

class CI_DB_query_builder {
    public function where($key, $value = null, $escape = null) {
    }
    public function get($table = '', $limit = null, $offset = null) {
    }
    public function insert($table = '', $set = null, $escape = null) {
    }
    public function update($table = '', $set = null, $where = null, $limit = null) {
    }
    public function delete($table = '', $where = '', $limit = null, $reset_data = true) {
    }
    public function select($select = '*', $escape = null) {
    }
    public function join($table, $cond, $type = '', $escape = null) {
    }
    public function order_by($orderby, $direction = '', $escape = null) {
    }
    public function limit($value, $offset = 0) {
    }
    public function result() {
    }
    public function result_array() {
    }
    public function row() {
    }
    public function row_array() {
    }
    public function num_rows() {
    }
}

class CI_Session {
    public function userdata($item = null) {
    }
    public function set_userdata($newdata = [], $newval = '') {
    }
    public function unset_userdata($newdata = []) {
    }
    public function flashdata($key = null) {
    }
    public function set_flashdata($newdata = [], $newval = '') {
    }
}

class CI_Input {
    public function post($index = null, $xss_clean = null) {
    }
    public function get($index = null, $xss_clean = null) {
    }
    public function cookie($index = null, $xss_clean = null) {
    }
    public function server($index = '', $xss_clean = null) {
    }
    public function ip_address() {
    }
    public function user_agent($xss_clean = null) {
    }
}

class CI_Form_validation {
    public function set_rules($field, $label = '', $rules = [], $errors = []) {
    }
    public function run($group = '') {
    }
    public function set_message($lang, $val = '') {
    }
    public function error_string($prefix = '', $suffix = '') {
    }
    public function error($field = '', $prefix = '', $suffix = '') {
    }
}

// Helper functions
if (!function_exists('redirect')) {
    function redirect($uri = '', $method = 'auto', $code = null) {
    }
}

if (!function_exists('base_url')) {
    function base_url($uri = '', $protocol = null) {
    }
}

if (!function_exists('site_url')) {
    function site_url($uri = '', $protocol = null) {
    }
}

if (!function_exists('show_404')) {
    function show_404($page = '', $log_error = true) {
    }
}

if (!function_exists('show_error')) {
    function show_error($message, $status_code = 500, $heading = 'An Error Was Encountered') {
    }
}

// Common CodeIgniter Helper Functions

if (!function_exists('lang')) {
    function lang($line, $id = '') {
    }
}

if (!function_exists('form_open')) {
    function form_open($action = '', $attributes = [], $hidden = []) {
    }
}

if (!function_exists('form_close')) {
    function form_close($extra = '') {
    }
}

if (!function_exists('form_hidden')) {
    function form_hidden($name, $value = '') {
    }
}

if (!function_exists('form_input')) {
    function form_input($data = '', $value = '', $extra = '') {
    }
}

if (!function_exists('form_textarea')) {
    function form_textarea($data = '', $value = '', $extra = '') {
    }
}

if (!function_exists('form_dropdown')) {
    function form_dropdown($name = '', $options = [], $selected = [], $extra = '') {
    }
}

if (!function_exists('anchor')) {
    function anchor($uri = '', $title = '', $attributes = '') {
    }
}

if (!function_exists('validation_errors')) {
    function validation_errors($prefix = '', $suffix = '') {
    }
}

if (!function_exists('set_value')) {
    function set_value($field = '', $default = '', $html_escape = true) {
    }
}

if (!function_exists('element')) {
    function element($item, $array, $default = null) {
    }
}

if (!function_exists('html_escape')) {
    function html_escape($var, $double_encode = true) {
    }
}

if (!function_exists('log_message')) {
    function log_message($level, $message) {
    }
}

if (!function_exists('get_instance')) {
    function get_instance() {
        return new CI_Controller();
    }
}

if (!function_exists('write_file')) {
    function write_file($path, $data) {
    }
}

if (!function_exists('url_title')) {
    function url_title($str, $separator = '-', $lowercase = false) {
    }
}
