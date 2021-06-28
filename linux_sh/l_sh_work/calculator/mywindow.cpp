#include <mywindow.h>
#include <cmath>
#include <QtWidgets>
#include <QColor>
#include <QString>

bool plusbool=false, minusbool=false, multiplybool=false, dividebool=false;
 double valuee=0;
Widget::Widget(QMenuBar *parent):QMenuBar(parent)

 {
    p = parent;
    createActions();
    createMenuBar();
    //----------------------------->прозрачное окно
    //setAttribute(Qt::WA_TranslucentBackground);
    //setWindowFlags(Qt::FramelessWindowHint);

    line=new QLineEdit;
    line->setAlignment(Qt::AlignRight);
    line->setReadOnly(false);
    line->setValidator(new QRegExpValidator( QRegExp( "[-+]?[0-9]*\\.?[0-9]+" ) ));
    line->installEventFilter(this);

    QVBoxLayout *vbox = new QVBoxLayout;
    QGridLayout *gbox = new QGridLayout;
    b1=new QPushButton("1");
    b2=new QPushButton("2");
    b3=new QPushButton("3");
    b4=new QPushButton("4");
    b5=new QPushButton("5");
    b6=new QPushButton("6");
    b7=new QPushButton("7");
    b8=new QPushButton("8");
    b9=new QPushButton("9");
    b0=new QPushButton("0");
    bclear=new QPushButton("c");
    bbackspace=new QPushButton("←");
    bplusminus=new QPushButton("±");
    bsub=new QPushButton("/");
    bmult=new QPushButton("*");
    bminus=new QPushButton("-");
    bplus=new QPushButton("+");
    bequal=new QPushButton("=");
    bcomma=new QPushButton(".");

    setStyleSheet("QPushButton:pressed{"
                              "background-color: rgb(0, 0, 0);"
                              "border-style: inset;"
                              "color: white;"
                              "border-style: outset;"
                              "border-width: 1px;"
                              "border-radius: 3px;"
                              "border-color: beige;"
                              "font: bold 14p;"
                              "min-width: 10em;"
                              "padding: 50px;}" );

    vbox->addWidget(line);
    gbox->addWidget(bbackspace,0,0);
    gbox->addWidget(bclear,0,1);
    gbox->addWidget(bplusminus,0,2);
    gbox->addWidget(bsub,1,3);
    gbox->addWidget(b7,1,0);
    gbox->addWidget(b8,1,1);
    gbox->addWidget(b9,1,2);
    gbox->addWidget(bmult,2,3);
    gbox->addWidget(b4,2,0);
    gbox->addWidget(b5,2,1);
    gbox->addWidget(b6,2,2);
    gbox->addWidget(bminus,3,3);
    gbox->addWidget(b1,3,0);
    gbox->addWidget(b2,3,1);
    gbox->addWidget(b3,3,2);
    gbox->addWidget(bplus,4,3);
    gbox->addWidget(b0,4,0);
    gbox->addWidget(bcomma,4,1);
    gbox->addWidget(bequal,4,2);
    vbox->addLayout(gbox);
    connect(b1, SIGNAL(clicked()), this, SLOT(bt1()));
    connect(b2, SIGNAL(clicked()), this, SLOT(bt2()));
    connect(b3, SIGNAL(clicked()), this, SLOT(bt3()));
    connect(b4, SIGNAL(clicked()), this, SLOT(bt4()));
    connect(b5, SIGNAL(clicked()), this, SLOT(bt5()));
    connect(b6, SIGNAL(clicked()), this, SLOT(bt6()));
    connect(b7, SIGNAL(clicked()), this, SLOT(bt7()));
    connect(b8, SIGNAL(clicked()), this, SLOT(bt8()));
    connect(b9, SIGNAL(clicked()), this, SLOT(bt9()));
    connect(b0, SIGNAL(clicked()), this, SLOT(bt0()));
    connect(bclear, SIGNAL(clicked()), line, SLOT(clear()));
    connect(bbackspace, SIGNAL(clicked()), this, SLOT(bs()));
    connect(bplusminus, SIGNAL(clicked()), this, SLOT(ps()));
    connect(bplus, SIGNAL(clicked()), this, SLOT(plus()));
    connect(bcomma, SIGNAL(clicked()), this, SLOT(com()));
    connect(bminus, SIGNAL(clicked()), this, SLOT(minus()));
    connect(bmult, SIGNAL(clicked()), this, SLOT(multiply()));
    connect(bsub, SIGNAL(clicked()), this, SLOT(divide()));
    connect(bequal, SIGNAL(clicked()), this, SLOT(equal()));
    this->setLayout(vbox);

}

bool Widget::eventFilter(QObject *wathed, QEvent *event) {
    if (wathed == line && event->type() == QEvent::KeyPress) {
        QKeyEvent *keyEvent = static_cast<QKeyEvent *>(event);
        if (keyEvent->key() == Qt::Key_Enter) {
            // Enter
            this->equal();
        } else if (keyEvent->key() == Qt::Key_Equal) {
            // Равно
            this->equal();
        }  else if (keyEvent->key() == Qt::Key_division) {
            // Деление
            this->divide();
        }  else if (keyEvent->key() == Qt::Key_multiply) {
            // Умножение
            this->multiply();
        }  else if (keyEvent->key() == Qt::Key_Minus) {
            // Вычитание
            this->minus();
            this->line->setText("");
            this->line->clear();
        } else if (keyEvent->key() == Qt::Key_Plus) {
            // Сложение
            this->plus();
            this->line->setText("");
            this->line->clear();
        }
    }
    return QObject::eventFilter(wathed, event);
}

void Widget::bt1(){
    QString s = line->text();
    s=s+"1";
    line->setText(s);
    this->linefocus();
}
void Widget::bt2(){
    QString s = line->text();
    s=s+"2";
    line->setText(s);
    this->linefocus();
}
void Widget::bt3(){
    QString s = line->text();
    s=s+"3";
    line->setText(s);
    this->linefocus();
}
void Widget::bt4(){
    QString s = line->text();
    s=s+"4";
    line->setText(s);
    this->linefocus();
}
void Widget::bt5(){
    QString s = line->text();
    s=s+"5";
    line->setText(s);
    this->linefocus();
}
void Widget::bt6(){
    QString s = line->text();
    s=s+"6";
    line->setText(s);
    this->linefocus();
}
void Widget::bt7(){
    QString s = line->text();
    s=s+"7";
    line->setText(s);
    this->linefocus();
}
void Widget::bt8(){
    QString s = line->text();
    s=s+"8";
    line->setText(s);
    this->linefocus();
}
void Widget::bt9(){
    QString s = line->text();
    s=s+"9";
    line->setText(s);
    this->linefocus();
}
void Widget::bt0(){
    QString s = line->text();
    s=s+"0";
    line->setText(s);
    this->linefocus();
}
void Widget::bs(){ // удаление
    QString s = line->text();
    int a=s.toDouble();
    a=a/10;
    line->setText(QString::number(a));
    this->linefocus();
}
void Widget::ps(){ //плюс-минус
    QString s = line->text();
    int a=s.toInt();
    line->setText(QString::number(-a));
    this->linefocus();
}
void Widget::plus(){ //плюс
    QString s=line->text();
    fnum=s.toDouble();
    s=s+"+";
    line->clear();
    plusbool=true;
    this->linefocus();
    this->line->setText("");
    this->line->clear();
}
void Widget::minus(){ //минус
    QString s= line->text();
    fnum=s.toDouble();
    line->clear();
    minusbool=true;
    this->linefocus();
    this->line->setText("");
    this->line->clear();
}
void Widget::multiply(){ //умножить
    QString s= line->text();
    fnum=s.toDouble();
    line->clear();
    multiplybool=true;
    this->linefocus();
    this->line->setText("");
    this->line->clear();
}
void Widget::divide(){ //деление
    QString s=line->text();
    fnum=s.toDouble();
    line->clear();
    dividebool=true;
    this->linefocus();
    this->line->setText("");
    this->line->clear();
}

void Widget::equal(){ // равно
    QString s=line->text();
    lnum=s.toDouble();
    if (plusbool){
        double c=fnum+lnum;
        line->setText(QString::number(c));
        plusbool=false;
    }
    if (minusbool){
        double c=fnum-lnum;
        line->setText(QString::number(c));
        minusbool=false;
    }
    if (multiplybool){
        double c=fnum*lnum;
        line->setText(QString::number(c));
        multiplybool=false;
    }
    if (dividebool){
         double c=fnum/lnum;
         line->setText(QString::number(c));
        dividebool=false;
    }
    this->linefocus();
}
void Widget::com(){ //точка
    QString s = line->text();
    if (s.indexOf(".") < 0 ) s=s+".";
    line->setText(s);
}

// Menu---------------------------------------------------------------------------------------------------------
void Widget::createActions()
{
    QPixmap exitpix(":img/exit.png");
    QPixmap copypix(":img/copy.png");
    QPixmap pastepix(":img/paste.png");
    QPixmap aboutpix(":img/about.png");
    QPixmap helppix(":img/help.png");
    QPixmap colorpix(":img/color.png");
    myExit = new QAction(exitpix,tr("Выход"),p);
    connect(myExit,SIGNAL(triggered()),this,SLOT(closes()));

    copy = new QAction(copypix,tr("Копировать"), p);
    copy->setShortcut(tr("Ctrl+c"));
    copy->setStatusTip(tr("Copy"));
    connect(copy, SIGNAL(triggered()),this,SLOT(copyb())); // COPY

    past = new QAction(pastepix,tr("Вставить"), p);
    past->setShortcut(tr("Ctrl+v"));
    past->setStatusTip(tr("Past"));
    connect(past,SIGNAL(triggered()),this,SLOT(pastb())); // PAST

    editColor = new QAction(colorpix,tr("Цвет окна"),p);
    connect(editColor,SIGNAL(triggered()),this,SLOT(selcolor())); // color

    helpAct = new QAction(helppix,tr("Посмотреть справку"), p);
    helpAct->setShortcut(tr("F1"));
    connect(helpAct, SIGNAL(triggered()),this,SLOT(oprb())); // Посмотреть справку


    op = new QAction(aboutpix,tr("О программе"), p);
    op->setStatusTip(tr("Справка"));
    connect(op, SIGNAL(triggered()),this,SLOT(poppub())); // Справка

}
void Widget::createMenuBar()
{
    fileMenu = new QMenu(tr("&Файл"),p);
    fileMenu->addSeparator();
    fileMenu->addAction(myExit);
    this->addMenu(fileMenu);

    viewMenu = new QMenu(tr("&Правка"), p);
    viewMenu->addAction(copy);
    viewMenu->addAction(past);
    viewMenu->addSeparator();
    viewMenu->addAction(editColor);
    this->addMenu(viewMenu);

    helpMenu = new QMenu(tr("&Справка"), p);
    helpMenu->addAction(helpAct);
    helpMenu->addSeparator();
    helpMenu->addAction(op);

    this->addMenu(helpMenu);
}
// Menu ----------------------------------------------------------------------------------------------------

// Line focuses --------------------------------------------------------------------------------------------
void Widget::linefocus() {
    this->line->setFocus();
}
// Line focuses --------------------------------------------------------------------------------------------

// Menu action ---------------------------------------------------------------------------------------------
void Widget::poppub(){
 QMessageBox::about( 0 , tr("О программе 'Калькулятор'"),tr("Версия 1.0<br> © Артамонов Михил, 2021. Все права защищены. <br><a href='mailto:maximalisimus121@mail.ru'>maximalisimus121@mail.ru</a>"));
}
void Widget::oprb(){
    QMessageBox::about(0,tr("Справка и поддержка"),tr("Данный проект разработан специально для курсового проекта..." ));
}

void Widget::copyb(){
    valuee=line->text().toDouble();
}
void Widget::pastb(){
    line->setText(QString::number(valuee));
}
void Widget::selcolor(){
    QColor color = QColorDialog::getColor("white");
    if (color.isValid() ) {
        //QPalette palet(palette());
        //palet.setColor(QPalette::Background, color);
        //this->setAutoFillBackground(true);
        //this->setPalette(palet);
        //this->show();
        QString onColor = " background-color: " + color.name();
        this->setStyleSheet(onColor);
        this->resetcolor();
    }
}
void Widget::resetcolor(){
    line->setStyleSheet(" background-color: white ");
    b1->setStyleSheet(" background-color: #F0F0F0");
    b2->setStyleSheet(" background-color: #F0F0F0");
    b3->setStyleSheet(" background-color: #F0F0F0");
    b4->setStyleSheet(" background-color: #F0F0F0");
    b5->setStyleSheet(" background-color: #F0F0F0");
    b6->setStyleSheet(" background-color: #F0F0F0");
    b7->setStyleSheet(" background-color: #F0F0F0");
    b8->setStyleSheet(" background-color: #F0F0F0");
    b9->setStyleSheet(" background-color: #F0F0F0");
    b0->setStyleSheet(" background-color: #F0F0F0");
    bclear->setStyleSheet(" background-color: #F0F0F0");
    bbackspace->setStyleSheet(" background-color: #F0F0F0");
    bplusminus->setStyleSheet(" background-color: #F0F0F0");
    bsub->setStyleSheet(" background-color: #F0F0F0");
    bmult->setStyleSheet(" background-color: #F0F0F0");
    bminus->setStyleSheet(" background-color: #F0F0F0");
    bplus->setStyleSheet(" background-color: #F0F0F0");
    bequal->setStyleSheet(" background-color: #F0F0F0");
    bcomma->setStyleSheet(" background-color: #F0F0F0");
}
void Widget::closes(){
    this->close();
    QApplication::closeAllWindows();
}

// Menu action ---------------------------------------------------------------------------------------------
