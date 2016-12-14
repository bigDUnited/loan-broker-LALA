#!/bin/bash
#Run the entire project.
p=$(ps aux | grep rulebase | head -n 1 | cut -f 4 -d' ')
kill -9 $p
proc=()
python rulebase.py &
ps aux | grep rulebase | head -n 1
proc+=("$!")
python creditscore_enricher.py &
proc+=("$!")
python bank_enricher.py &
proc+=("$!")
python recipient.py &
proc+=("$!")
python danskebank_translator.py &
proc+=("$!")
python nordea_translator.py &
proc+=("$!")
python nytkredit_translator.py &
proc+=("$!")
python bdo_translator.py &
proc+=("$!")
python dummylisten.py &
proc+=("$!")


python client.py

sleep 2
echo "${proc[@]}"
p=$(ps aux | grep rulebase | head -n 1 | cut -f 4 -d' ')
kill -9 $p ${proc[@]}
