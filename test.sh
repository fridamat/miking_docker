#!/bin/bash

perf stat -r 1 build/boot tytest test/master-thesis/sequence_tasks.mi
