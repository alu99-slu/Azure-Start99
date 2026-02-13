#!/bin/bash

Name="Stu"
Course="Shell Scripting"

echo "Welcome $Name"
echo "You are learning: $Course"

Cur_Date=$(date +%Y-%m-%d)
echo "Date $Curr_Date"

Num=10
Num2=20
SUM=$((Num+Num2))
echo""
echo "Total: $SUM"
