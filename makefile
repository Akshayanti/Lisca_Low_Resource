#!/usr/bin/env bash

get_data:
	sh generalScripts/get_pud.sh;
	sh languageSpecificScripts/hi/extractData.sh;