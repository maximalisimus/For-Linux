#!/bin/env bash
if ! command -v "osd_cat"  > /dev/null; then
	clear
	echo "
		Для вывода информации на экран установите xosd"
	exit 1
fi
if ! command -v "sensors"  > /dev/null; then
	clear
	echo "
		Для измерения температуры CPU установите lm_sensors"
	exit 1
fi
echo "

Запущен мониторинг температуры
для отключения нажмите Ctrl+C" | osd_cat -c white -s 2 -O 1 -f -*-*-*-*-*--20-*-*-*-*-*-*-* -l 4

for ((;;))
	do
		sensors 
		sleep 1
	done \
		| osd_cat -c red -s 2 -O 1 -f -*-*-*-*-*--20-*-*-*-*-*-*-* -l 6

# расскрасить выхлоп по мере преближения к tjmax
# добавить мониторинг нагрузки 
# добавить gui
# добавить утилиты для стресстестирования
