#ifndef MYWINDOW_H
#define MYWINDOW_H

#include <QWidget>
#include <QtWidgets>
#include <QMenuBar>
#include <QMenu>
#include <QAction>
#include <QMessageBox>
#include <QValidator>
#include <QLineEdit>
#include <QEvent>

class QLCDNumber;
class QLineEdit;
class QEvent;

// Главное форма
class Widget : public QMenuBar
{
    Q_OBJECT

public:
	// Конструктор формы
    Widget(QMenuBar *parent = 0);
    // Переменные для хранения первого и второго числа
    double fnum, lnum;
	
	// Текстовое поле
    QLineEdit *line;
	// Кнопки от 0 до 9, а также кнопки очистки, равно, вычислений и дробных значений
    QPushButton *b0;
    QPushButton *b1;
    QPushButton *b2;
    QPushButton *b3;
    QPushButton *b4;
    QPushButton *b5;
    QPushButton *b6;
    QPushButton *b7;
    QPushButton *b8;
    QPushButton *b9;
    QPushButton *bclear;
    QPushButton *bbackspace;
    QPushButton *bplusminus;
    QPushButton *bsub;
    QPushButton *bmult;
    QPushButton *bminus;
    QPushButton *bplus;
    QPushButton *bcomma;
    QPushButton *bequal;
	
	// Экшены автоматических действий
    QAction* myExit;
    QAction* editColor;
    QAction* copy;
    QAction* past;
    QAction* helpAct;
    QAction* op;

    bool eventFilter(QObject *wathed, QEvent *event);

private:
    QWidget* p;
	// Главное меню
    QMenu* fileMenu;
    QMenu* editMenu;
    QMenu* viewMenu;
    QMenu* helpMenu;
    QMenu* editlist;

    // Процедуры автоматического создания меню и экшенов
    void createMenuBar();
    void createActions();
    void linefocus();
    void notEditLine();

protected:
    //void bt1(QKeyEvent *event);

public slots:
    // Действия кнопок
    void bt1();
    void bt2();
    void bt3();
    void bt4();
    void bt5();
    void bt6();
    void bt7();
    void bt8();
    void bt9();
    void bt0();
    void bs();
    void ps();
    void plus();
    void minus();
    void multiply();
    void divide();
    void com();
    void equal();

    void poppub();
    void oprb();
    void copyb();
    void pastb();

    void selcolor();
    void resetcolor();
    void closes();
};

#endif // MYWINDOW_H
