<?php

$finder = PhpCsFixer\Finder::create()
    ->in([
        __DIR__ . '/app',
        __DIR__ . '/config',
        __DIR__ . '/routes',
        __DIR__ . '/database',
        __DIR__ . '/tests',
    ])
    ->exclude([
        'storage',
        'vendor',
        'bootstrap/cache',
        'node_modules',
    ]);

return (new PhpCsFixer\Config())
    ->setParallelConfig(
        PhpCsFixer\Runner\Parallel\ParallelConfigFactory::detect()
    )
    ->setRiskyAllowed(false)
    ->setIndent('    ')
    ->setLineEnding("\n")
    ->setRules([
        '@PSR12' => true,

        // Style rules
        'array_syntax' => ['syntax' => 'short'],
        'single_quote' => true,
        'no_unused_imports' => true,
        'ordered_imports' => ['sort_algorithm' => 'alpha'],


        // Consistent line endings & trailing commas
        'trailing_comma_in_multiline' => [
            'elements' => ['arrays'],
        ],

        // Clean formatting decisions
        'binary_operator_spaces' => [
            'default' => 'single_space',
        ],
        'no_whitespace_in_blank_line' => true,
        'no_trailing_whitespace' => true,
        'no_trailing_whitespace_in_comment' => true,
        'compact_nullable_typehint' => true,
        'curly_braces_position' => [
            'anonymous_classes_opening_brace' => 'same_line',
            'anonymous_functions_opening_brace' => 'same_line',
            'classes_opening_brace' => 'same_line',
            'control_structures_opening_brace' => 'same_line',
            'functions_opening_brace' => 'same_line',
        ],
    ])
    ->setFinder($finder);
