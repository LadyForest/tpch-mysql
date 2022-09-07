#!/bin/bash

time ./dbgen "$@"

# keep container alive
tail -f /dev/null