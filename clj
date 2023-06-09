#!/bin/sh
    breakchars="(){}[],^%$#@\"\";:''|\\"
    CLOJURE_DIR=~/Documents/clojure-1.8.0
    CLOJURE_JAR="$CLOJURE_DIR"/clojure-1.8.0.jar
    if [ $# -eq 0 ]; then 
         exec rlwrap --remember -c -b "$breakchars" \
            -f "$HOME"/.clj_completions \
             java -cp "$CLOJURE_JAR" clojure.main
    else
         exec java -cp "$CLOJURE_JAR" clojure.main $1 -- "$@"
    fi
