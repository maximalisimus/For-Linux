#!/bin/sh
PS3='Please, select to love ovosh: ' # строка приглашения к вводу (prompt)
echo
select vegetable in "Bobi" "Morkovj" "Kartoha" "Luk" "Briukva"
do
  echo
  echo "Yes to $vegetable."
  echo ";-))"
  echo
  break  # если 'break' убрать, то получится бесконечный цикл.
done
exit 0
