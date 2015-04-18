#!/usr/bin/env bash

#cat DebugLog/*.swift Vendor/DDFileReader/DDFileReader/*.swift
awk 'FNR==1{print ""}{print}' DebugLog/*.swift Vendor/DDFileReader/DDFileReader/*.swift > DebugLog.all.swift