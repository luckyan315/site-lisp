#!/bin/bash

prepack()
{
    cat << EOF
(function() {
    var stack = [];
    var modules = {};
    var definitions = {};
    var dirname = require('path').dirname;
    var basename = require('path').basename;

    function _require(path) {
        if (modules[path]) {
            return modules[path];
        }

        var module = {
            id : path,
            exports : {},
            parent : stack.length ? stack[stack.length - 1] : null,
            __dirname : dirname(path),
            __filename : basename(path),
        };
        var definition = definitions[path];

        if (!definition) {
            try {
                return require(path);
            } catch (e) {
                throw new Error("Unable to load " + path);
            }
        }

        stack.push(module);
        definition(_require, module, module.exports, module.__dirname, module.__filename);
        stack.pop();

        return modules[path] = module.exports;
    };

    function define(path, definition) {
        definitions[path] = definition;
    };

    if ('undefined' == typeof global) {
        global = window;
    }

    if ('undefined' == typeof window) {
        global.window = global;
    }

    if ('undefined' == typeof window.process) {
        window.process = {};
    }
EOF
}

postpack()
{
    cat << EOF
})();
EOF
}

wrap()
{
    local path=$1
    local repl=""

    echo "define('$path', function(require, module, exports, __dirname, __filename) {"

    grep -roE "\.+(/[a-zA-Z\.\-\_]+)+" $path | awk -F: '{print $1}' | while read module; do
        dir=$(dirname $path);
        mid=$(realpath ${dir}/${module});

        if [ -z "$mid" ]; then
            mid=$(realpath ${dir}/${module}.js);
        fi

        if [ ! -z "$mid" ]; then
            sed -i "s|${module}|${mid}|g" $path
        fi
    done 2> /dev/null

    cat $path
    echo "});"
}


wrapall()
{
    local tmp=$(tempfile)
    local abspath=""

    find $1 -name '*.js' -type f | while read path; do
        abspath=$(realpath $path)

        wrap $abspath
        echo $abspath >> $tmp
    done

    while read path; do
        echo "_require('$path')"
    done < $tmp
}

prepack && wrapall $1 && postpack
