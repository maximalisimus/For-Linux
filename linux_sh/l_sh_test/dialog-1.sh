#!/bin/bash
DIALOG=${DIALOG=dialog}

$DIALOG --title " Мой первый диалог" --clear \
        --yesno "Привет! Перед вами пример программы,\nиспользующей (X)dialog" 10 40

case $? in
    0)
        echo "Выбрано 'Да'.";;
    1)
        echo "Выбрано 'Нет'.";;
    255)
        echo "Нажата клавиша ESC.";;
esac
exit 0
