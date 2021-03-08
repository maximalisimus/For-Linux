#!/bin/sh
PS3='Please, select to love ovosh: '
echo
choice_of()
{
select vegetable
# список выбора [in list] отсутствует, поэтому 'select' использует входные аргументы функции.
do
  echo
  echo "Yes to $vegetable."
  echo ";-))"
  echo
  break
done
}
choice_of Bobi Ris Morkovj Redis Tomat Shpinat
#         $1   $2  $3      $4    $5    $6
#         передача списка выбора в функцию choice_of()
exit 0
