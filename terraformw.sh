#!/bin/bash

TERRAFORM=$(which terraform)

./precheck.sh

TERRAFORM "$@"
