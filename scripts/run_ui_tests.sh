#!/bin/sh

bundle exec fastlane ui_tests --verbose
	RESULT=$?
	exit $RESULT
